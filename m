Return-Path: <bpf+bounces-17571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3179780F587
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 19:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610EF1C20D5D
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 18:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1614E7E79B;
	Tue, 12 Dec 2023 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Poyc8LD9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4FFBC
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 10:29:17 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5c69a28af6dso5587160a12.0
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 10:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702405756; x=1703010556; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AYIP5+st5oTeIS131b4Sztiu9q9HKQNtVOHXt0oAhBI=;
        b=Poyc8LD9bkF/UMosOlIRsst8cUMRaLJRE0TpvT4Al27C7uWjxNNq1q4zfm2aTYhfKk
         2RCaX4AgJhG9Fnggj8zF1yjoliaH8Aryj0GpIecAbGhcEZVEwQUernUG4Wt/oGnsHEDc
         T3myP/QewzbeknsTqi/DPqwT2k2Ssq/u7lp/gr+gLJ0ySV1aB/krgnpeZpukxi5p45LP
         w1ZtT285exqHs63+U3NOJtwiRBdh6sU5pbX0v/LxNogeqOOUZiMuKYYaVq8KntUrY6ah
         Zwxz7O//TVKFc0grrzTH8TTGuv5v8bYgTpxnqA4fU0m1Nd68E1w0oT3Zyd1h60hE+pSN
         6mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702405756; x=1703010556;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AYIP5+st5oTeIS131b4Sztiu9q9HKQNtVOHXt0oAhBI=;
        b=K+lvg8vuXqJx+aS5LXyggc2jXGJ3fDc7njv0//m4jGtnJ5rTL/XKlfAzWk/d5o5ARF
         ONxZhfKaNUr7v9w+fTHsNO8WJVwShP9KatERl/AFKT8iGQEhjbpJ+BH5zINeKo4TuGjM
         DJNUzbFG10Ya+gvrsyYb6gKkZgnj3xLG96E+4m+VP+HTMJ9Lm4vEUfD7zubsoYleLqyT
         rkfI5rMoThpArdP9MirbIKTfQQ7ZLHZIUMKF78yGFxOQ30Zn5mYQbhkYOwUqYqsMOQ/k
         ZRj1IWJWHQb70WhSkr607QB2VpQvf7LYNusg1F8D5EioB4tC0taYtpakWbo4IkWEFvy6
         66DA==
X-Gm-Message-State: AOJu0YwTii+A4hDJla8Alt468kcumeHwZESoaIy6gIjClSuAduHSPG/g
	zz3FUIMYNq54erYMXYyJf/h0u+AwSuxvrCoBCZNFU3XJPlFx6LF+gqbhpEy40fUVc44O6vqraHr
	8yYO3vSz8b0ERb+nI/lpAulc1TNr/EFaBD2sZYu1JgC8QcKqcY86ujsd7A82FwJ0=
X-Google-Smtp-Source: AGHT+IH4crZt5o0eIqg86ZjtNMy4RPjpsaV4VZNq1KBCiIpDji8N4RoZq2icsZGskO3/Y/XHhGAIIclDgqAhcA==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a63:4f:0:b0:5ca:31a3:e117 with SMTP id
 76-20020a63004f000000b005ca31a3e117mr13620pga.11.1702405755841; Tue, 12 Dec
 2023 10:29:15 -0800 (PST)
Date: Tue, 12 Dec 2023 18:29:11 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212182911.3784108-1-zhuyifei@google.com>
Subject: [PATCH bpf] selftests/bpf: Relax time_tai test for equal timestamps
 in tai_forward
From: YiFei Zhu <zhuyifei@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Stanislav Fomichev <sdf@google.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>, 
	Kurt Kanzenbach <kurt@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

We're observing test flakiness on an arm64 platform which might not
have timestamps as precise as x86. The test log looks like:

  test_time_tai:PASS:tai_open 0 nsec
  test_time_tai:PASS:test_run 0 nsec
  test_time_tai:PASS:tai_ts1 0 nsec
  test_time_tai:PASS:tai_ts2 0 nsec
  test_time_tai:FAIL:tai_forward unexpected tai_forward: actual 1702348135471494160 <= expected 1702348135471494160
  test_time_tai:PASS:tai_gettime 0 nsec
  test_time_tai:PASS:tai_future_ts1 0 nsec
  test_time_tai:PASS:tai_future_ts2 0 nsec
  test_time_tai:PASS:tai_range_ts1 0 nsec
  test_time_tai:PASS:tai_range_ts2 0 nsec
  #199     time_tai:FAIL

This patch changes ASSERT_GT to ASSERT_GE in the tai_forward assertion
so that equal timestamps are permitted.

Fixes: 64e15820b987 ("selftests/bpf: Add BPF-helper test for CLOCK_TAI access")
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 tools/testing/selftests/bpf/prog_tests/time_tai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/time_tai.c b/tools/testing/selftests/bpf/prog_tests/time_tai.c
index a31119823666..f45af1b0ef2c 100644
--- a/tools/testing/selftests/bpf/prog_tests/time_tai.c
+++ b/tools/testing/selftests/bpf/prog_tests/time_tai.c
@@ -56,7 +56,7 @@ void test_time_tai(void)
 	ASSERT_NEQ(ts2, 0, "tai_ts2");
 
 	/* TAI is moving forward only */
-	ASSERT_GT(ts2, ts1, "tai_forward");
+	ASSERT_GE(ts2, ts1, "tai_forward");
 
 	/* Check for future */
 	ret = clock_gettime(CLOCK_TAI, &now_tai);
-- 
2.43.0.472.g3155946c3a-goog


