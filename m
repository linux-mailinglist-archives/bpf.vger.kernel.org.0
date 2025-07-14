Return-Path: <bpf+bounces-63229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B356B0472D
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 20:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864851642C0
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 18:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDECC26FA5A;
	Mon, 14 Jul 2025 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="GOEwqv7C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CA526E709
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516577; cv=none; b=FxDSMaIYBAnVI4YOv5K15u4rZ44o+CdNoOSLOFNhGPS05ix000mFbhPitG6YsX2YP8sRA7gBrUe5W7VN2AaTflwiEpOpHGMSOfa2oGH46lm25ZVCoVfzN45emWW8DFRkg/yhotm7jCYDmgS2ISvLxEzX/q+8Sj3rUGiyMvp6ONQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516577; c=relaxed/simple;
	bh=foepoQWthtqzAO/amSXmA+Ijs1+fWhMG2CBZ9t6Tz18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFWyXf5hKMcvwL0ujSzqJOZXTpDPWWD21lxiE5OFn7IYiJOIeD4C6cH9wD0099XPQY1N3CSVOBN1ad/L5x0+jM7SJVc9+oIr+r6pJt03dOt6mrE7M0ixbH+2A5SD/l/FZTngQgU4I4JbZvN3yvcagzAM/2oh6WiKg58ndNxBlWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=GOEwqv7C; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23de2b47a48so4981905ad.2
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 11:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752516574; x=1753121374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=GOEwqv7CetpVbUDPzX0i2vocinxDIQcmiOQ9hGm5gfzjtBjRFYljAxCv+66qrWwDBd
         gJFfmbcOBc+WnUaBhKYIVRoRx+YWvuE/SY4DEn7ZpAsfoppa+ASjaC7u9DIaZDhobgKG
         5Ku7a++TM4baiwEmcvCi940uO0oi0izDLZI+StkB0KDz4ra6o3F9puehGlxn9xD9+ryc
         9xCkPv8WocEMYwe70jP3jzScAe36BAwYUieqxK6alaXWgR33LfZadudhp9VKiwEn+RyW
         /ZW6Ar+83NrqsQHK8eQJRWDszKdAOMqPs1kpJf29SlZGvvpR2MGzxqBAw47/101+bBXI
         mZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516574; x=1753121374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=gE/UEWH+8hetRmu1YKA1FDFYGzW9lyIUDiSRpAR33kZbPD2CARpPx3cyM7VwEkY3ha
         4Mta8ebg0wVMihZ6PQTXfSayrONatBk57O8N0CYiUgNh2ZKBLl/47TXuNJR7rsoitg7L
         ngDVkdfhtrA9YitzdUpf0VnV66llfDZXhTZqPosZnKdV/VgSU4pDnN2AdPOEFLZoafEv
         y2wwMx6RHyfcndHQ9bueyfbUaOap1nxYMn03a0HfyCBcmV8WPAn+81ebZJXfpzwgh+fW
         jr6gvBp1/MjKnzcHJXwRnMTjZr2mjpxH+k5d16GgASmhJOpMKrMtieRTYr9XH2kb0B+N
         2Evg==
X-Forwarded-Encrypted: i=1; AJvYcCUKLEPcSjrM5H/L5A2mNLpYvU4Kv9M4E9Uegj4Vg6zn2e8QLk1SHvW4ab6kALVHACnpj1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMoT4CoEj6AftZ2BAJdsecuKBRUoed4XD5Oqn2uW3TNtrwGNHQ
	61kI/OO1QkoKaedZDLfFYDh4JwiJPgYjeal5xG3Y4W62NkVMrudG6Ccmju6Cr+zJXfY=
X-Gm-Gg: ASbGncv8Ro0HV72+ca/eaEvNMXM3jPMIVSE5iObaprRkKaXTQ9Vf6CKQPWLQ59Jx2xU
	CwMz6eOEKAiBUcNilxkpqq8zllvjsOPNaAzcD6/4udM9Ls+LdrIsurDN0R5WQ25FdixWj5q69kl
	txRjttGK8+MFKOlpNah3fFgm9uXpCIp2BFd+wjU+e/IH83GT+tYpTW090ka/FgtKOfVgYuklWIi
	X1d9VXCI8fpbp3w92LBQjQmiwsm2aVLF/qZIKGCmJT80KefZnIjAUuhOEf4uFW3yhauo2NAvNqw
	+q0FxfaOy6uretutEwrHvgx4HJ9QkNdNSITxPZBNpsTXYtYJf/Ii41nuRVkB6m+z67wejCXCd2u
	27QAjwzc01w==
X-Google-Smtp-Source: AGHT+IF4LbK0d6KAHKC4bWQilGTFlSFuomzHi6+LSsRe/rrXjA3H6SuX2zl4/HR0nX9LuMCyYeJBSg==
X-Received: by 2002:a17:903:1c9:b0:234:c8f6:1b09 with SMTP id d9443c01a7336-23dede84f28mr74980305ad.9.1752516574381;
        Mon, 14 Jul 2025 11:09:34 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:84d3:3b84:b221:e691])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aeadcsm98126405ad.78.2025.07.14.11.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:09:34 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 06/12] selftests/bpf: Add tests for bucket resume logic in listening sockets
Date: Mon, 14 Jul 2025 11:09:10 -0700
Message-ID: <20250714180919.127192-7-jordan@jrife.io>
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

Replicate the set of test cases used for UDP socket iterators to test
similar scenarios for TCP listening sockets.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index a4517bee34d5..2adacd91fdf8 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -358,6 +358,53 @@ static struct test_case resume_tests[] = {
 		.family = AF_INET6,
 		.test = force_realloc,
 	},
+	{
+		.description = "tcp: resume after removing a seen socket (listening)",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = remove_seen,
+	},
+	{
+		.description = "tcp: resume after removing one unseen socket (listening)",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = remove_unseen,
+	},
+	{
+		.description = "tcp: resume after removing all unseen sockets (listening)",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = remove_all,
+	},
+	{
+		.description = "tcp: resume after adding a few sockets (listening)",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_STREAM,
+		/* Use AF_INET so that new sockets are added to the head of the
+		 * bucket's list.
+		 */
+		.family = AF_INET,
+		.test = add_some,
+	},
+	{
+		.description = "tcp: force a realloc to occur (listening)",
+		.init_socks = init_batch_size,
+		.max_socks = init_batch_size * 2,
+		.sock_type = SOCK_STREAM,
+		/* Use AF_INET6 so that new sockets are added to the tail of the
+		 * bucket's list, needing to be added to the next batch to force
+		 * a realloc.
+		 */
+		.family = AF_INET6,
+		.test = force_realloc,
+	},
 };
 
 static void do_resume_test(struct test_case *tc)
-- 
2.43.0


