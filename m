Return-Path: <bpf+bounces-62528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 079BCAFB7F9
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 17:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632BD18999D6
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 15:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88DB218851;
	Mon,  7 Jul 2025 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="giFO+u88"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02238217733
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903477; cv=none; b=KTU0+W3T05jlxMidkW8N9g2VbvVLt1VziMxjunuWMf3fwp5hJmdHsqRZvvszO6KSMrKZXdSnODT6WyKOet2xKt+dYo98qJdstMoRGK3CAy5GsvojaMTVR8uDb/X3jxBvlROdz00hTTpseHjshpzqY+shg7qqIifoBQryGfBJZV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903477; c=relaxed/simple;
	bh=foepoQWthtqzAO/amSXmA+Ijs1+fWhMG2CBZ9t6Tz18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngDgELR256gE+HdEdzzzwLt8+I86pZnbO+6JNh4dJQbHb/+8sSlKG9lQfe1vFHcoPzgwnm9kooGHh9gnkv8tIF+A3ctty0IE/Zfwvn7fBQS5hSLThLmVBevoaDy+82vYzv1I6NtVvN/AAztzmTHX05M04wcB3Uz4xNRbSesQ+mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=giFO+u88; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-237d849253fso3864455ad.1
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 08:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751903475; x=1752508275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=giFO+u88Y7Hf7GXjkK0JY3IVOVYnSDUcL9U3AX8srcEiL/fvJ4YOM+z37eZ3/IxWSd
         y2ofPe0j+QfzGjr+fgj4zKAhpjftbhtuDnRLdEvdSjc46ERApY0eusDaGsn1CTxLk6td
         ElxqDWgAy6lZR04W87+m3ieqvs+X0vLCphmtDJAVcUoGpfZlIGFa4tD2diZNkDPPpfT+
         KNguFHb3jqAUCeEcwVhhC6Mer2yZ4CfmamzU1GZ7AUebVjrGYKPcfNc8lzn34RomROTv
         WhSpg6CFP3DVjFJC7iack+GBAoc1I9ZWzsYVrL1Ry503dYb+k/9TAk3FvLq2wfo+y6kK
         JBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903475; x=1752508275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=QOQnEiOWnIex7lcydNL8yioztrVlx8oWrPKkZ6491XYW1B3AJTD0qHtzN80pSoK8xq
         OFJFiRJdwqE7k6qOFPLluwqA00SfJCHQ4uCD3QT8UOkDBe4bkUJiJgWnw2kkOyo0QdoB
         7YKLLFrBwRSr/Dhzj07tHznXQKxGSM54yQyxpuCQTjbulJOkcnz9X7x+z/OMyghovFEq
         qN/gbzhT7yUrWS5erhqCCHG9bWCmup8O1mJUqF2rOYsbzyvZ7+INsnlao1xTeDJ4I85H
         zizFqVtDk8YZL3IDXj0DIGeysmpeQFpmgL5hRvBGP1KYwzEI/M4+JvnWOjzE8sX38pRD
         QCVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm97wO0OUGFGoHLpDwiVjoIYXm+dk103sT3Y27374OPp6AGuyJePjSen+8XE7x98ISqDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIwshy1FG4N3rviQzThJezDNekZGGjhQtq61FamRr055CCACx7
	AK57OsKzShppRI0bI2BlywG6vFkRVczrAnIrmBaq1m8seFQhiPymvDAEpbufBv2kJTs=
X-Gm-Gg: ASbGncvKqXZmp0zpfeyGYC+1d4b9be24glsV6jvU33Dr13pT28ryNDHxFyeBl2ZyWtX
	K73QyKxWwYAdp/vyjllxrcL4BusInAx/DmncNa6tpYzkTDNIUSG2nwLVdox9bwCbkt2hJc0R45F
	6uS8OGVsyBIVpxPgL5s31ILYU2hppUNq5yIXRXMcw0JxdEg4qhPpMdeehombe5qJHFHTzJJeVFJ
	w5oeydHhtOsdhqu9AcfaSTLwM2ShilTOr9woqhMlneNJVUuKh71QdOMHBLtF8zSpVzkRJTeyjVH
	Hr8BUQ5r4bxMLR4N7oLSrK3jT2dvLIfYplCWWEEFV8ESjgjn1QI=
X-Google-Smtp-Source: AGHT+IGhaVoioRrlut1mESqPdvOatp22KS6ApbAHvedQjoF0tvtLxJzI8k+NZUmMGjcsyzU+ev1FaQ==
X-Received: by 2002:a17:903:1c4:b0:234:a734:4abe with SMTP id d9443c01a7336-23c8722f4fbmr73864625ad.1.1751903475242;
        Mon, 07 Jul 2025 08:51:15 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:e505:eb21:1277:21f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455eb3bsm95772065ad.115.2025.07.07.08.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:51:14 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 06/12] selftests/bpf: Add tests for bucket resume logic in listening sockets
Date: Mon,  7 Jul 2025 08:50:54 -0700
Message-ID: <20250707155102.672692-7-jordan@jrife.io>
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


