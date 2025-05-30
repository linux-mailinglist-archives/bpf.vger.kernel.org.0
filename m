Return-Path: <bpf+bounces-59383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EF8AC971B
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 23:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9331895CE0
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 21:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D3628467B;
	Fri, 30 May 2025 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="aJ4AnNfe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4682820D9
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640704; cv=none; b=A+cKqwD3NI+3KbgSRPMfVKh8qVw+S6PY8kLVMZ3IfJ7mKhYOWETfP0/3H09ZRo/I7rPtvzW6HIso+rxT/GV+x9VP88FOTKaUeqMFQdZ6NVOCNNNNqClCE60Ig/+fx+GLfpunGpjAn/fCPZFwd+fzdo+G8UyuTwQ+4KgtFPyoFdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640704; c=relaxed/simple;
	bh=foepoQWthtqzAO/amSXmA+Ijs1+fWhMG2CBZ9t6Tz18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DbSLdFexA65YcIGQrmoT2A04i/l3RF8Ce7mzUCklAv7CN7G2YCDGzuz6xHe5KXAYshKJZit/thdXO2rSANgqk3YNesMUxNcUKS95I/7o9zygAH4J4iRCx4lgAQB8NjxiJrP7mFWx67+qQTwYLLsVmHHwPDAoXw62OMmGavSor7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=aJ4AnNfe; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b2ed1bc24fcso132013a12.0
        for <bpf@vger.kernel.org>; Fri, 30 May 2025 14:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748640702; x=1749245502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=aJ4AnNfeCPeYY2af4jEVbMnPxMdpFpUc1CQ1CozrVhQLKZo24Qq/hXmOFOJ7Iad747
         F4DQF+rLOeUSy/UwGA9b5Ud0r/iQSkMYM4gOix8EfpSlTqWyXlYIRYnReKkSRPjKUL5m
         6+HphqupsK54H4CMCakn9B7n27txl/dmxTP/7gnUUL97NvbsWGtckPTY/LlHC9oH4gpf
         c2HT3/+YkzAdNANnl7PuNdCfByy4zbVXU482rRK7KIHNjnzjImPF/ypVC6HG+O8nrbky
         llpmjdvD1If6sDnx9C879qEgv0/fiNYSBMTu8SfLAP8po8RqMOH2wX0R4PW87Xd85eg3
         PGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748640702; x=1749245502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=e93HX56Nn3EBZq+1sonBuWm4mbbo6d3V19CsdGuZ90V+ryLHdcaKTUsjs24ddvWQBP
         diyCrB4eCa+cIFyUHv503tgmwcnAyMXeLPuyN9pqNYjUnVvnVdfCYy2izMhi82neVQHJ
         PBaZ1EzjrHFznSR2PITonADrWGAufW4rb16J5Viu+Ur4n50/qbB0+Qx60kJyEz74J1IF
         jwMzOK6We23Dtfhr+zLN4i0n4BHuuqeY+WIWx1K26Mg6btp0RytyIgFuxqnzKvTxeSUy
         ul4tK/gMQOKBaSrDZLU8XbIhgTFWRNUvsRHYjD02SSFBCBJFYqkWe8OSE05IbSbGxezC
         PoJg==
X-Forwarded-Encrypted: i=1; AJvYcCVzKF3RT2acO/CHa5tdfx3od7wcgQn60lAbwmje8j6/W3mgqHRV9p9rdIRTXNu5Gu0nkXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIg/k6029RcGrunwztoR8A9Dic5kGbRNaqui2LSfegDTX6Hg9N
	AZnug891NH2e8N4ovsfgZg52BKUpjpygKSckK090mt2DOWmg/SZcFHI2usjyxdomb9s=
X-Gm-Gg: ASbGncuwkWIrxhWWzAPYPh6WqmGiHQXJZmo35Y6i+jTKTzTFkNflYUmcyXDSWaVN0NR
	sdqiQWiFWcUjkG9xi2VaZZQLkxW5pcdLepfajpJa7UAG/enzyWqs6RSBwKnjYXyeQV0WQj0TCbF
	kBWUC/4Nw5CLpFzQh877i3iNWtj8lYl1o9dqb6NARk+1cqaNaYAhSEVMwx7QdbESq8StkajfXPN
	zqQHs+XXjBpaHFTqtvF03qJ/5lDRVqQMsN4cuUiFJrqG0cCCgji05Jz0NM1YnUu+wXQsB59ZUpk
	LbZ89zuiLZmQWXBvSPAkAXB9WmFMNFlWR5Ot7waD6rxmeUl1GG4=
X-Google-Smtp-Source: AGHT+IEENTTAKUrUNR+3M564GJ71ofsBrK+42Jr9x0yqH/77Gm6K5ghMNr4QFnq7xGKkyH71AaOr7g==
X-Received: by 2002:a05:6a00:4b01:b0:730:8526:5dbc with SMTP id d2e1a72fcca58-747c0eb1109mr2194524b3a.3.1748640702175;
        Fri, 30 May 2025 14:31:42 -0700 (PDT)
Received: from t14.. ([2607:fb91:20c7:44b2:2a24:2057:271e:f269])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed4399sm3496763b3a.77.2025.05.30.14.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 14:31:41 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v2 bpf-next 06/12] selftests/bpf: Add tests for bucket resume logic in listening sockets
Date: Fri, 30 May 2025 14:30:48 -0700
Message-ID: <20250530213059.3156216-7-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530213059.3156216-1-jordan@jrife.io>
References: <20250530213059.3156216-1-jordan@jrife.io>
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


