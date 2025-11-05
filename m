Return-Path: <bpf+bounces-73630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C091C35CEB
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 14:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847E7567B11
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 13:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B90C31CA7B;
	Wed,  5 Nov 2025 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3+SbHc0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5026E31DDAB
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762348877; cv=none; b=bw5KfcTVpZkSCw0VjWDiEJsenh2BT0yh6TsB5xsXdjW0i87UMlN/UjkmAucki3NnM0JTOhRAlMTz+8xAJ9t+ETrrGjJyFXRgAEHXF7DaX0iK24jBSJFXB1SIf9PBAHn5UaIY1OGRQt9lVBp088KMKza5DzH7O5YR01xTtGDFLQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762348877; c=relaxed/simple;
	bh=D83E5qDS5i+ZHkelB00pfPjmpUFe9vjkwy7wVzeDphk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gjX8kVrRK1fHzUkzzlCYNCRiWH1ds8p05W3uEGq1/HkKB7viaj1U7PQFw8+aecdjfB2HW8qJ2r/+xSlg0Z8GZVUCRWJmfSmp0TbqbkY6m9gh5ErLen3/tf5bA2uqB/eo3GAXjteeXtHczuH1YIFC2w5qh2fhjzQuobU3NL+/xMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3+SbHc0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477549b3082so16752295e9.0
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 05:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762348873; x=1762953673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qpdwg+cgEsb1TET/SoByNhYyXKKhhYtIdEXtpag4Y24=;
        b=d3+SbHc05tSukI1Yuw4MehW01ua9qlb9nkbyaeyFW9Rdpeg6PTyP/qxPayTc8zvpkt
         03c3LWZ6h1OHvN97UhvschQPaXMnlL+ryZ4SRIYRKUjohoOj6Zglr8l+NzqLdxuQZdAF
         psMZMD0xZg0awi4n+4164dkiebMA1T7d/Rwgy8c+75Y7iAHPjCRK25hf3JWcHPOjLVS/
         fmzRNQ3ZRCsPLoOe9nd+ZIYqzABxEiF8tdg9UiFawoj59w7eNIFCiXnB3CRCAjRIneAd
         08FgbD1XuURCLZ6JgLnHkO+yKf+F4W4esPhlgeIh9rPq4nf0K8nBCqX1HB08Dr6KRBoR
         m8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762348873; x=1762953673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpdwg+cgEsb1TET/SoByNhYyXKKhhYtIdEXtpag4Y24=;
        b=Kt9ekP1MRXabBvK+DiJo7XGf8l9MTbD9yrpor7wjn8AopwrdzIYr2CG2OhVok5Byad
         N+EIB9rA1omi3/+5FrSy2OtPCGoKQ+mFP6DewIvY0I42HIoT5ZyAvBsbKoKXxLBJ2jYC
         oho9C4kjNGb6e2QUMmArWh9h0cordCFzvqUjD8ydBRJNkLCignv++Ywe2jZE9uW187pj
         G1aGRRtXzH1IJ6aLXYXuXzJBg5EoYautAmOtSrRbHXy25+K+tSUrElvUWHNibWxv3htL
         ubfKunuRS5OMlpxRO+nV5Kuh0/2lr5cFYweITwJ4F24BAM3xnQT1CFU5qU7WZR02B7Ut
         4g6w==
X-Gm-Message-State: AOJu0YwZJiBsg/Q5SZCOgRWCNcsBY5qo6towXRskN7xAMFv/QitfGGY7
	lGlYl4GXGl3bBHXZqzUQXhUPLbbT8rDXS1LVtdH0bUj7F719GJqCtGlpO05r3A==
X-Gm-Gg: ASbGnctiMY7+DUMnJmuL5+MvKnDLMW3K/J1kAqlBhUAGSxb/sLvQZpNweOuVA86pBkq
	GFSOpMxX2Cj0FcUtZcR6qHUthiM/FnRI4dPKeLqaG/M9QSeZboxeBxIy+jY8IcTLmrJjLDqHmsS
	RtBc18Z8rh7HekUSuGyfwdRd1HbWxsWDqXl8A7oMrsS2CEOEx42IZLnhyaexgfUyn528ZKcXNLW
	X/cgPWIgD8Wo9LDUZ9XXDhyPx7pSyT9PWEOEwVlrdpesbEHHEXq5GV3dZUwW39UInRbsy8aVrx6
	EwE32Ln4VQbOT6mJmKLNaNH7/aqgEahAOCj1/wrniopPibBtweP6cMoHrSre+xig8Zt1kBX3heG
	+tGm9r5TJG4a/Dr33WYTcKIR1ZGZZU9mMgqa6zWUuwlSCYoB0o/YeKtdVXW8V
X-Google-Smtp-Source: AGHT+IELYlv1wUxJdnf09zQGnijJ47XsqoQoNMMFCSP4KSCetrug8zKa/px0tV0b6s0xBf0K3+KbYQ==
X-Received: by 2002:a05:600c:8b84:b0:475:d8c8:6894 with SMTP id 5b1f17b1804b1-4775cdbec8fmr24083005e9.9.1762348873292;
        Wed, 05 Nov 2025 05:21:13 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::7:64d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775593e876sm45004105e9.5.2025.11.05.05.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 05:21:12 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v1] selftests/bpf: align kfuncs renamed in bpf tree
Date: Wed,  5 Nov 2025 13:21:05 +0000
Message-ID: <20251105132105.597344-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

bpf_task_work_schedule_resume() and bpf_task_work_schedule_signal() have
been renamed in bpf tree to bpf_task_work_schedule_resume_impl() and
bpf_task_work_schedule_signal_impl() accordingly.
There are few uses of these kfuncs in selftests that are not in bpf
tree, so that when we port [1] into bpf-next, those BPF programs will
not compile.
This patch aligns those remaining callsites with the kfunc renaming.
It should go on top of [1] when applying on bpf-next.

---
1: https://lore.kernel.org/all/20251104-implv2-v3-0-4772b9ae0e06@meta.com/

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/progs/file_reader.c               | 2 +-
 tools/testing/selftests/bpf/progs/verifier_async_cb_context.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/file_reader.c b/tools/testing/selftests/bpf/progs/file_reader.c
index 166c3ac6957d..4d756b623557 100644
--- a/tools/testing/selftests/bpf/progs/file_reader.c
+++ b/tools/testing/selftests/bpf/progs/file_reader.c
@@ -77,7 +77,7 @@ int on_open_validate_file_read(void *c)
 		err = 1;
 		return 0;
 	}
-	bpf_task_work_schedule_signal(task, &work->tw, &arrmap, task_work_callback, NULL);
+	bpf_task_work_schedule_signal_impl(task, &work->tw, &arrmap, task_work_callback, NULL);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
index 96ff6749168b..7efa9521105e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
+++ b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
@@ -156,7 +156,7 @@ int task_work_non_sleepable_prog(void *ctx)
 	if (!task)
 		return 0;
 
-	bpf_task_work_schedule_resume(task, &val->tw, &task_work_map, task_work_cb, NULL);
+	bpf_task_work_schedule_resume_impl(task, &val->tw, &task_work_map, task_work_cb, NULL);
 	return 0;
 }
 
@@ -176,6 +176,6 @@ int task_work_sleepable_prog(void *ctx)
 	if (!task)
 		return 0;
 
-	bpf_task_work_schedule_resume(task, &val->tw, &task_work_map, task_work_cb, NULL);
+	bpf_task_work_schedule_resume_impl(task, &val->tw, &task_work_map, task_work_cb, NULL);
 	return 0;
 }
-- 
2.51.1


