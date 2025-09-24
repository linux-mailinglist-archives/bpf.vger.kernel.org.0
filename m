Return-Path: <bpf+bounces-69540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 255ADB9A3F2
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 16:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC4F17E001
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 14:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21E23064B8;
	Wed, 24 Sep 2025 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWD+o7t1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0C1188596
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724200; cv=none; b=HsRBEGY2mcupt9F+6pwP6eCEM0rGzKBwoguDpyMKobfP5lwX+koiA4IL5qTw0Nw6d6pB3TtJhRlm4V6V4lxu06mC2vtYKQ0nqk4eCKiSPf+3Tch3Tt90aprzDuVCiDqb6TP/4v06apaU6IWoBJFZgYTuaKMJDfvPT+Nnf69gzYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724200; c=relaxed/simple;
	bh=BRzXLqW0uc4UUbk1eSHWP60AuZW72D0ULdcpto/mQ88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTbpyCrxW7VjdiO6wPkEzTqSqjbHzG0GuJKkH9U1Myb0+QsK2sGH5MQrq025JGpAQCN+KkDHIbzd24BLew5QTx6JWvVSlsK8/D0JtDP9b4nECuGG8fzTuyAJacKmCcvwTBNhcTly4ZRD4PhGF9nBD0ZfR4R7gesT/s+IT/xO8cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWD+o7t1; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee12332f3dso6818149f8f.2
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758724197; x=1759328997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uY4RFsSRbdkCyx+pkaPIlawDiLoE33lkgVzKQelOKGw=;
        b=cWD+o7t1UqzrhTT2uALUGKqBPUdkHlX+qepE/umt8+Ww+EzSTaJPCGULj1gNw0x/Bk
         p2dG/aTYbDXspWQctQ0Ar0puiN5zLnRNznUSnTUXOJ16KVJFe9eY0iYB1IFmJT7aP9XM
         kgQhpCa59W45kpYUwKsLcC8BWwgvJvAEJgSEe4SACkYlqG38ZknhAEDZBk3WsUEHC2l7
         +bFePEtkFNfMubztmfI9SvY+bQHx0mjSpcyXEctsuzLkEL7qYjomstpN10Pn9rhMmK3H
         iRBcXnWxIrCYYvGZ9U5mHd45m9TyrSMHYjiV+lDbbPaQdPJTcglJzM3AClbYHaqui31Y
         IrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758724197; x=1759328997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uY4RFsSRbdkCyx+pkaPIlawDiLoE33lkgVzKQelOKGw=;
        b=PHAoGMUc0yni4CrsBvXLaEpaWY4uu13ngXZ09OejiGDHEHzxpBFarYLXEV3Nsnmmsb
         ISgvwIn34aY0O/OWlmbFfznJ/AV8oi8ENzP3PZtig+WpRYsV2FGhNLZ9M9MtZjkiFKj2
         Z4pBpQYAytQJMDPN7TPLQd4Ian5psZjSUhIFQeKgx4uIqJLkmMag701EEaT08Lu2TW5k
         qgus3qaSuNHAuOLcwi5NOSAqFkd/6h1WYhF6WB4lg8/aXHU2F1UemauoRjlO0HE5FI4X
         3MXY9UveXKa3eyD95zYUFl0WdzVa4kc8r0LqBMJ66JnpXVIshkRjYzdVCFG9IG1koJco
         n0zQ==
X-Gm-Message-State: AOJu0YzecpUJQuQMmdV7e9PlbOpaOWmFopnqf10oOHV78Pjo1X0lYH0q
	0wWfqzc/9TkBwcRArKarE/Xauk5f95hvnt/5grAZd0q2ovEy5C0nEoF6U/UkCncZ
X-Gm-Gg: ASbGncvCkMH/HgoifH8IfVaWbvbjxuA6xcpDEzhiuMXr/DHBT5Ru/2RbKmoseL6BrHb
	SvNWmLhR79hL6MM6lHxKMfMK8cP+TKUXL+gvm08hquMH8e5cTXSeG9sJhNySDMf+08C62rM68WP
	kjEHjcoCEpJam/STV09+qBAFzNyNa3/t8diZ29SDlcr5r/lCF/olzX+hDyPic3ncKmSvre6vEBs
	0UGyHyqCki2l8s8X3FE60Agg7GFiau5XFcjqr5n+H/gy8HHTAAlJ6ui7JcLxojNJ5KNe4HkZMk7
	JiXOygtfTfESQNq0+cNr77Uz9cC+XuTocf1YRhZO7GzUtWGMxsW1Gsvh2sc11rpSspH+ssD4Pm7
	Knk5ngAzooaPROZ9Cr88JQw==
X-Google-Smtp-Source: AGHT+IEBcHhZLEg6PKqfwuxHcVOAK0OUVirl/Fm4G/mCKFn0/TeCt9YtLnUFZKRNu57hAwxo3q04vA==
X-Received: by 2002:a05:6000:2901:b0:3eb:60a6:3167 with SMTP id ffacd0b85a97d-40e4bb2f6c4mr142781f8f.32.1758724196751;
        Wed, 24 Sep 2025 07:29:56 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee074106f4sm28108808f8f.25.2025.09.24.07.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:29:56 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: fix flaky bpf_cookie selftest
Date: Wed, 24 Sep 2025 15:29:53 +0100
Message-ID: <20250924142954.129519-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Problem:
bpf_cookie selftest fails if it runs after task_work selftest:
perf_event_open fails with errno=EINVAL.
EINVAL indicates incorrect/invalid input argument, which in case of
bpf_cookie can only point to sample_freq attribute.

Possible root cause:
When running task_work test, we can see that perf subsystem lowers
kernel.perf_event_max_sample_rate which probably is the side-effect of
the test that make bpf_cookie fail.

Solution:
Set perf_event_open sampling rate attribute for bpf_cookie the same as
task_work - this is the most reliable solution for this, changing
task_work sampling rate resulted in task_work test becoming flaky.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 4a0670c056ba..75f4dff7d042 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -450,8 +450,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
 	attr.size = sizeof(attr);
 	attr.type = PERF_TYPE_SOFTWARE;
 	attr.config = PERF_COUNT_SW_CPU_CLOCK;
-	attr.freq = 1;
-	attr.sample_freq = 10000;
+	attr.sample_period = 100000;
 	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
 	if (!ASSERT_GE(pfd, 0, "perf_fd"))
 		goto cleanup;
-- 
2.51.0


