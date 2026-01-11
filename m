Return-Path: <bpf+bounces-78498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 064D8D0F8B3
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 18:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B896530336BB
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 17:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAE034D388;
	Sun, 11 Jan 2026 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKUfeRwY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A3C1CFBA
	for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768154326; cv=none; b=uOJOciKvEN3QLCUGAnpR7r7sDw4eCQS8yzGPW/6N2tL4M3vRi19B9HZz4rF7R7a+DZeXS1aVUGTjU7S9Gxg0PkKZP+cm2X/hWB314HOqN0SIX/gd3RTaE4VP9Bhkuf7qdqYRJ/Bl3rm3/DDvPfyvEbS/BZ8MZascDB1vPABYkKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768154326; c=relaxed/simple;
	bh=+83YL3qD9TWSimD+8UusUe59U3XjoA0xGj0maLh3hoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NRiT+vJ3sCEJlGT5kG+5txCfLGcBOEhTJ2zWb1Khx8sWCI1a6gf8JvoYQNoy1G++OB4CxOXvvT1LR7YfZ/3YhpEzYBijGX2CVcP/j+97B6vyVi5Lbq2osZ1cnvJatsziUMe8G/VsMMkdP06WH2L9Z7U6qYGpB3bPWdh3iw1jzyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKUfeRwY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a07fac8aa1so42738235ad.1
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 09:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768154324; x=1768759124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cJc1D8R2YBiu5D974m8O8Nx8rnuow8VZR4p+bCCtLrY=;
        b=lKUfeRwYaK7YX7GcD/htbcP1NTDefJqvzBak0/2i3cI9AWi9dG8gOfQ9t9IO2bNaWd
         xIS+k32X112OUPK1Cev31ezdMpB5eV2HpCZrYSzSUdAokBoUivI/RUCrpOUdlHMnPFMR
         ksLwPtXfQ2lQXL0rmz/nAteEMM19URM4EEjyTVHiZYmcRHTp7kfpABkdEgLqcrM+xdT9
         mLMPW5uzg+8dRbdKyQGiNdhu+bDuoSCujHkdZEk5CRBUa/N3X1jk66XewRPtYY6LV20P
         FT+SlpMjOv4kC/ZbQLPUxwvoruPYUVsXjWeLRxGIiX+FQazTIPnMik6Vk6vfGbUrfCUS
         EEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768154324; x=1768759124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJc1D8R2YBiu5D974m8O8Nx8rnuow8VZR4p+bCCtLrY=;
        b=mqt2IxRKsSo4MHRdzzFtPlNA1xiWb0k9p8/5C3navrckuu96r2QBDska8b8VVCsAUb
         qD7mR9Bolvi5SJTRG5j8N9rx26fO2woqDZCBzLBgLhQNpQP4aSjycIKmd3NRmxm2AB17
         awD+H+iCFZOBYWTl+BNZxWX5wQFxZuCvMSrnRESJoP8FUr4R9yklSEtPPLtuuMl9peMb
         PzLUZuYMctWMeoHeT6ll1AVhvXdUIFCwYO0nb31A3PiWVsAazcQtwGVuY6BXCTbVJ+n/
         JRx5IDcCEKUxhfnSuTwxQyaBmeUJ1DdJvYqjChA/WPigoKe2jbWmPefw5D/6M6RNa61q
         ZyoA==
X-Forwarded-Encrypted: i=1; AJvYcCV2HW8QpaDfaGZhnAvDjPnrvoqPVaRY7HUiLCN14WcGa4S4PSF5UqX2UcwYp6RcBpFD2Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze366gOpNUa9Wes3fhKzD8wO89NsdIiup04wXxjxKrR9AeeNz1
	VhFZ55ctMJrP+3lYEfLx4a5edjjmtaGX2EwiQ72uxaLmJB8X3pSPS3qBE6tfWWzTfZZrO1qf1A=
	=
X-Gm-Gg: AY/fxX6iE1MuZ532QYqo4tZfYrdlGkv2z6y8nCnACFGhhbKuRfy7r1KDGStyAUqTtDv
	VqwizirlmCv+u0Bv0KGFKSgCs7Rbm4tWYdT0VJOZtK0V8Qghtb5/gOF32DECB2JuLminvdP1Qzp
	DROfsiyX2A5m/d1WcpHU9zj+Ihu2Id0o+/nt4sNpBPAmnAyl6oFsCpfbomfda62c4zypWR2pLAW
	r/9uJY7klz6hc82/kAR0zMk7IAkxkP9LPxtUoCn6kAm4jGyZKbvQCVd5DVsC+sisCyrSxIVMakN
	Csf6SIHxnsNv2969mUTryFtcE4HtUE9YNTcd/Nz5T6lUI2qHYKx4TGrRyGOTN7Gn3fEL0Ul30n5
	ONm0Y/7QOaJsajSxPwaPTxd1D1ubZE6i+PYiPPwYD7jHazJ/t5XtBIBK/XQUMY6S+KFHvcdWGyv
	IDPr0H2YAESFs0giIY
X-Google-Smtp-Source: AGHT+IF+4UulXIgDfPVYlRNXOHSjoNS39a8rLC+Re/eb594AGYz8NOEQpk+SY3gd01gxDowSUmsyig==
X-Received: by 2002:a17:903:2c9:b0:295:9627:8cbd with SMTP id d9443c01a7336-2a3ee4aae3bmr168309855ad.33.1768154324493;
        Sun, 11 Jan 2026 09:58:44 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([45.136.255.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc88fcsm152180335ad.83.2026.01.11.09.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 09:58:44 -0800 (PST)
From: Kery Qi <qikeyu2017@gmail.com>
To: andrii@kernel.org
Cc: martin.lau@linux.dev,
	bpf@vger.kernel.org,
	Kery Qi <qikeyu2017@gmail.com>
Subject: [PATCH] selftests/bpf: wq: fix skel leak in serial_test_wq()
Date: Mon, 12 Jan 2026 01:58:14 +0800
Message-ID: <20260111175813.2252-2-qikeyu2017@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

serial_test_wq() returns early when ASSERT_OK_PTR(wq_skel, "wq_skel_load")
fails. In that case wq__open_and_load() may still have returned a non-NULL
skeleton, and the early return skips wq__destroy(), leaking resources and
triggering ASAN leak reports in selftests runs.

Jump to the common clean_up label instead, so wq__destroy() is executed on
all exit paths. Also fix the missing semicolon after 'goto clean_up'.

Fixes: 8290dba51910 ("selftests/bpf: wq: add bpf_wq_start() checks")
Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/wq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
index 1dcdeda84853..328c393e7167 100644
--- a/tools/testing/selftests/bpf/prog_tests/wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/wq.c
@@ -17,7 +17,7 @@ void serial_test_wq(void)
 
 	wq_skel = wq__open_and_load();
 	if (!ASSERT_OK_PTR(wq_skel, "wq_skel_load"))
-		return;
+		goto clean_up;
 
 	err = wq__attach(wq_skel);
 	if (!ASSERT_OK(err, "wq_attach"))
-- 
2.34.1


