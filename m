Return-Path: <bpf+bounces-69538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 160B3B99B21
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 13:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA38A18968C6
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 11:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D0B2FFDCE;
	Wed, 24 Sep 2025 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/N+RtPG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE0A2E54DB
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715068; cv=none; b=V9lC7fUyiQd3vKezAbuA639wiok31vs9jsKy7EvhtDukPz3a8YBrNOOpFgfjjyTr11z8RvymrZ4pJTeyZr59qY+htlvew+Bryb34tZ5me59wUwspdFAV1uNwTDWwuDMBr1hS4fn/eHMCeUVj8BdvmyECL88/eF/H/8u7FATBmuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715068; c=relaxed/simple;
	bh=rCaaygTqPB/F/lNFSnYb2RQvpeb3V5C//V4uRrp3SqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z/PEJx4GlnBr2GoyFqek5UbZttPlZFL97CbOau718E94OMhFHmywHwWRLCMK2zzHke1vaGbyW9Y7Yc3NWh8qYsklV5rLzryKvRHdkUOeNj7xLYL88XAy5jhKFrHIFrJpKwzrEnOxsTKonCrH02KGyV75Q6xpdwxoYbpY+bI8f7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/N+RtPG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46de78b595dso17882965e9.1
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 04:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758715062; x=1759319862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/NmlER6pzMnFDPqlXu62wTlJEIIcU+BcxzvdYsha9Lk=;
        b=V/N+RtPG9QozsVAszq6HqyGn82Z29mXfIjCiywsPUMvOcwCWGGni3w8pdmgPtUQ/mO
         SPz+iI4br2PyjOdxDLmzS1Zp6iB+J5d+aAgiK1i6JRubhfyXzQV0eoba0ukUrCKO4l8n
         mUucHouEeEWaWwXs82w4tYQIKdx7uFnFqFvMX9jnMpDXbBLXlFLzgb1KQLdq9FG9DLYf
         FerXlNki3uy5zxJDaLnqrDfne+zrvbInnalg0iPXS3hnEcCEs8dUo5v/rltXe1Q0dDrL
         5ZAfFfMrSgs+Gthoy4vldjyKcWA3lhsEEYKbe31yHUgzqgRkmFH3+n+6JvW/y79ARmdY
         vO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758715062; x=1759319862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NmlER6pzMnFDPqlXu62wTlJEIIcU+BcxzvdYsha9Lk=;
        b=KTjc5gVWCjfW1vH5/wzu7d1fAtu8CmhDBEQG4ZY3+g93oh6+fzduOdSVBUocgUD8Kn
         BkYQ/QXnSpiUJzE4cSzYjiqJyCUJYYYFKjp53ctnrsgpLljQcqu2gDZ8eSdDAXIb0tzZ
         4YOu5ziU8UzqkV4x69hCfOi4vp80yFgiPwHz3bToUufvcD2EqxLCvCmpZFpe3988gjlP
         QqyoeLaL281mE0yOufiEPq2tt+VJzDbi4PiSTaCYYpl1J5RcaOcQbns+k3eWjoSl4lTW
         aybwuEMdB59nKTm35G1ojmQTirlDKbaVxIpohoe/3mYglKLovoVUAg6rjGACQPuuJv/C
         yFYw==
X-Gm-Message-State: AOJu0YwUhaPWlZn9cWD57zu9PiMDzPHn/Inut+uCrUDFL9bKVT4QLWr9
	Zf7J3yB/UBQiINuwR2Lj1pRrCX6qWi24Pn/JOFH3pWoTbTcjNVjCgh4xvxdssed6
X-Gm-Gg: ASbGncvV7S8Zs9uYdD7sBJTnwiD0APG/7eCYtitdDXqD97J1pWqZRumrDaQb/4dQJp2
	M1shPy6/mcOHm/qhM3hHMOq9ljOjMhs31RqatMznfYX9xpqzwpulS5b2Z1XhUhqTcqKVmGN5gmp
	b6qXm11ZiBGV5bCcj01MFMog0qfnuWkkathAetN+7GVGGzR1PargRITx1fYmviBKhDUSw5UxJO3
	vESwnYAjf7JGSkTidPiZacJPRNFQ9aQVZ5YdwUQGTHdhAHET94rwCQGKKgxUQ2iVU/MXIszY3pP
	DeGvoBm5gP5TXuiwqOvRAcshLJNWTlYXJ7ABVTdR6Q3Qe14qYjQIFxez7HODE7egOHClDTNyaau
	RX59hA3TWz1J57apuv2LbmA==
X-Google-Smtp-Source: AGHT+IF0pMsM+IqQ3bz4qVyMENhf26RLwW0NsZTDet/BpfoE2XrzBQux5HzjS6R6eehQyOaxlu4XsA==
X-Received: by 2002:a05:600c:3b82:b0:45b:8477:de1a with SMTP id 5b1f17b1804b1-46e1d974657mr65760105e9.7.1758715061484;
        Wed, 24 Sep 2025 04:57:41 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9b6e1bsm33086405e9.10.2025.09.24.04.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:57:41 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v1 1/2] selftests/bpf: fix flaky bpf_cookie selftest
Date: Wed, 24 Sep 2025 12:56:59 +0100
Message-ID: <20250924115700.42457-1-mykyta.yatsenko5@gmail.com>
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
 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 4a0670c056ba..53a3bf435479 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -450,8 +450,8 @@ static void pe_subtest(struct test_bpf_cookie *skel)
 	attr.size = sizeof(attr);
 	attr.type = PERF_TYPE_SOFTWARE;
 	attr.config = PERF_COUNT_SW_CPU_CLOCK;
-	attr.freq = 1;
-	attr.sample_freq = 10000;
+	attr.sample_period = 100000;
+
 	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
 	if (!ASSERT_GE(pfd, 0, "perf_fd"))
 		goto cleanup;
-- 
2.51.0


