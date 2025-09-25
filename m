Return-Path: <bpf+bounces-69782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC49BA1B01
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 23:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151781C83CA7
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 21:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8A6260580;
	Thu, 25 Sep 2025 21:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3rar/6+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D92A23D2A3
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758837158; cv=none; b=bAFTFbT6vY7XxEGu7vBnGepmRIa2s5sVcmwehmHxNqx63f7P5Ci9GY4NPXzG8oCgDcUhJlxZQYqsHVWaTpahA2SmEyBIaNp+HbnXoNguf6czVXqEY1K2j1qQqychQm3nDElZU7whESQaIfkAj2QJoERb/YMwvnfEvqzstMb8z7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758837158; c=relaxed/simple;
	bh=pt0PWF1iYeb6Pq+UhU9hf4xPveXSlksvc0rvOsg1Agc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NbExIymseoCB25HglFyB4EiL1b2A2wo8JkrAoeY86klM34efTYfR8l6fmeWnYSrfdS6Zm4bUj4bXf59cOZuwL3Jz99165yBEigVsbGSPfO8Kd1uXLNxJcJJpgvkt3F9thdStRIMloCijGzqnKR4+jr70pgobqJ0lUruhx3Pqv3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3rar/6+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e1bc8ffa1so15229325e9.0
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 14:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758837155; x=1759441955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mLHHbHGfPj3J3/wKQu2mQmlChmV4J+DsdRekIjllmZg=;
        b=T3rar/6+57+Yhb/DSkMqSrLDqYnSxYnHyuFzi+dB1AwglRVAVLBduDZiBfCJmZxPW5
         rCBPgfR9tod/4CPpgXK6sXW3eM6lwHp56D5IF4+7aPJB/nYzK+NYOAxF1+QXqcHc/rEc
         tN+0cwcjjyErOWlZCYC/RNIjTbQ7AcIz91gkStTJ4aJFmdQMIc8SIUn+ZhlqZIlfUQe4
         unhXrVjj4RJV4b2bXQDO+xIzV8jhTvLnyvvHOVrm41teBnDV0GmgilFTDN+juYUXvL9m
         psfsKDLjR4T5ZLjqBNVImAL0eHjVA+XP4zf4GlztxlkR/G8PDXWJh+vp4LQWR0IOmGjY
         w5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758837155; x=1759441955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLHHbHGfPj3J3/wKQu2mQmlChmV4J+DsdRekIjllmZg=;
        b=iA+GcS8wR6HV0LaDP7J8xk6/DqdpXfi8EOMG+0RDQB3ajVKBLRBEl1BHdmqYk7vP+C
         Bx5HKB6K+bTVFUELsYPJU/i00GQXK+4X7z9+ekwNnBWePqYknbOl9xmdK25X6oGDxnWz
         19q7rSPD9x43ypOb2mqqsCOnGaQFRJLGXzxvJVDi1vbMMu9JOu8aQvgLpi8stHmMp1z3
         xg0Zplh2XLd24jdk7CpPw2wySgsMdwxt5I4Y/+pGfc/b3o6U7m1d8D5hX3vvonYJy7KY
         iirwNb+lnzZRNvLKfwa09scJ4C5mg3E5P789/aKexDJP/tQjO1b0Lz9cw3p7VOU2H3xn
         WBmg==
X-Gm-Message-State: AOJu0YxpFT4cJIb0+vs3JItXCO70ERKAGvowHbPYXugnPq5f4ZetM+iq
	TbODVclHS42r5HScQbr9GnfJb/aF4iN/sgHy9vyA+0SbganDt7jtbrZe1c3ZlQ==
X-Gm-Gg: ASbGncskgNIl6MXlYGlPeT34ELTG4Z/vxqI7rhsrsvPCUyf6eojoDH21wXw9GJLCYAy
	1+iBS4meaJnrmav4X32HUwEAuWidyWQuGQrnZcCMRYH+Hb2oTTWevZFReszScHlRAlGAujbe4JT
	9Csuqtrwn0mwYeW7F8Wxu/mkbkfDOASVZbWobUoNi/sNtSGNjUzH+pVS0fy9I6Ounp1RWc2lmBY
	oyWfjttWZtdN4ERCE+t6Jgx92ogxo1ipf/6C1DK4Eq00rf8b82nm2oaz5PGZnPtgY4cHDu6qs/u
	gBJoRsCI4faK6EoHN1kEJdhAKl+1//C5/uzlxk3LS1WlJ0uCnhqPVVSt1wShZm6AfIIRTgLHTuw
	U7dVqdRJgB/DbzLjD/GOSzA==
X-Google-Smtp-Source: AGHT+IE0S1suVE5vI1auCI2NVSPQSPPbUM8vU/itsEkP48Ypv+3CQAcrcIaPNx+dUPLzcrT6yckLbQ==
X-Received: by 2002:a05:600c:4ec6:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-46e329aed1amr53689775e9.6.1758837154953;
        Thu, 25 Sep 2025 14:52:34 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31e97sm92290605e9.14.2025.09.25.14.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:52:34 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2] selftests/bpf: fix flaky bpf_cookie selftest
Date: Thu, 25 Sep 2025 22:52:30 +0100
Message-ID: <20250925215230.265501-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

bpf_cookie can fail on perf_event_open(), when it runs after the task_work
selftest. The task_work test causes perf to lower
sysctl_perf_event_sample_rate, and bpf_cookie uses sample_freq,
which is validated against that sysctl. As a result,
perf_event_open() rejects the attr if the (now tighter) limit is
exceeded.

From perf_event_open():
if (attr.freq) {
	if (attr.sample_freq > sysctl_perf_event_sample_rate)
		return -EINVAL;
} else {
	if (attr.sample_period & (1ULL << 63))
		return -EINVAL;
}

Switch bpf_cookie to use sample_period, which is not checked against
sysctl_perf_event_sample_rate.

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


