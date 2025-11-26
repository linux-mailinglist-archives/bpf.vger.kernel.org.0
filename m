Return-Path: <bpf+bounces-75611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A84FC8BDC0
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 21:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67BFD4E2349
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 20:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F99342158;
	Wed, 26 Nov 2025 20:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKahpG9F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25653128D7
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 20:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764188971; cv=none; b=WK+ICD+2T9CGxqEy0jlWmY/GMzluAyoLqn0ezMf2ZVMfxWwj9TRgL4ta74xifbeEBTUu+C0fPpKCrVpz2vQHkKHFzkPmkhzPhbdzipd9dVhpP2Wkvo9uunMQytPo0LqzwREgnHc0j6Kixv21vTCHoadik2q/9ou9RKcfkMhHZj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764188971; c=relaxed/simple;
	bh=lAAQc7xd6oFsAOROKkH+MEF8DwuLg8BeqVAKNU4oVDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5n+jo+PJgKv+1VJtWeVaflMyjEo27A0lX3KWdJO+bpriC49xVlKIUlxa85ejtpMtp6fEI9/rL6HWGyLeZ1qOQsbkreIWGe/oavlBNmceg5PKn/rmkGfpGyeRyhmQoO7O/ml7NKLI9PSNfmm2+cMhK9L5CdNPCPQRROblaPdep4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKahpG9F; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-341988c720aso116775a91.3
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 12:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764188969; x=1764793769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VS/g3RQnyFYr3RVFNbZOZbsdYQEXcQXRpSTyZJjMzUo=;
        b=WKahpG9FtrEy8I+XyjAY4HRUGZ+dHq3lwpFETHYM1s1wFYuMVwPCleiZQWPpV/GQUU
         ngBjJ2BfBozRABf3L6wGWCXkJO3X5dfRbpWv6c1OeRDujTUtyqtbew3lwhnoPqPLqwdO
         uAn8FWxhhUr8U0/YBOnV5r9Zpt2hbS/yk0SCEynPx+Z9Qhwsu8d8mdIS/c85ZDAQ7Yo/
         jdju7mqNbqjWbG6y62Ok3EdAJDGYf5qehUA+D2JwGjy9UpVWB4rhLRePQOWmsuQ0cLs/
         AeQgTDIJZcpphAp7FpIsOc72cqmh3G+wkaaCd9fGWELQWtNbvMV31nHaawgJD6qdr85s
         OHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764188969; x=1764793769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VS/g3RQnyFYr3RVFNbZOZbsdYQEXcQXRpSTyZJjMzUo=;
        b=cRPnEPn9Xm8wAQTuM4fWmNFHRkHJgUcjT/K6NqvYGPaWAfboRsUock12b/Kn3VDsWm
         /2BD8CJoTuHI2WqembOL362FZMOjG7LYlzQwi/xc8428jtUbHDgn3R4YN5ECZH4g4env
         VH/2zeomR0QMmTZmEIqvqUbzyr8327pboaFllcCI4xdUYk1o/ovUOyskQtF2yAsN6L07
         BVw4ucZ1Xo6d+K9aqXalTL6E+rosWaDjHTduiRoO1I8k9wAHpQw7ZnPuIH7iF33c3VIJ
         ItMKcuUVamn3/bvejPolVa05AueoEga1DrSaWMju0qBEslbaK5m3tZfQBWqRwxRk+Ven
         sagw==
X-Gm-Message-State: AOJu0YxgiMTq3edNQWdE6mXsvGPdFwiplaZHF0y8LylLuFY2khxundq9
	UOfBNq4al+FzSjGGKiluDP3X6mL7HL3dfgngRHSXiuoEOS5LbNGcO//bb3ZmwQ==
X-Gm-Gg: ASbGnctmUq+zNrMqheMeuI5yFBmHSCeCMyM3vrG4xRDLhpZ4CKBK+GowbF7I1TYQYnl
	5fdeV5efVZOEC/jSIoEWFWsS4I9JOtFP497GLWuIds1zK3Alm7MW1k1n03gZB/k/RQHoBgxhY//
	n+0aFAXoQ6AMJ60xFqAZkg/BNB3ntqRprn5RWYdy75yIBWbipxYzhWLcrxu+ESJpWNVJHxTUcrB
	tMTvdep1krAnJpjmFzmTLoOdAR36PVTI1DnjFbsMBbLT9+mAE374ayFCEqJFTxkAdRzTjsX/OUl
	f0JtWxyhjWckJIQDbxuvA1qorP68hRLK5qxGTTHQs9gnTGctgw7R9EvrxDv/RjSXlfxLAy7lE+i
	m6NlAFH/cD3EyPUZ6mKe7RJuyEqC39n8gsSSFAqDRWRXeJCwDWQDYX7sxT3cp1FVg2Otb+fLx3g
	xYvSuJVaUx4UV6
X-Google-Smtp-Source: AGHT+IFQrwmugybzAePXlZbgduyUMXLSYlGTyfkv1o+H/fUNUJ5uK9/lVQdKPgWhnXmTti+WbNQC6Q==
X-Received: by 2002:a17:90b:268d:b0:32d:dc3e:5575 with SMTP id 98e67ed59e1d1-34733e6cab1mr18221211a91.5.1764188968947;
        Wed, 26 Nov 2025 12:29:28 -0800 (PST)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476008a69fsm2578510a91.10.2025.11.26.12.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 12:29:28 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kaiyanm@hust.edu.cn,
	dddddd@hust.edu.cn,
	dzm91@hust.edu.cn,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Remove usage of lsm/file_alloc_security in selftest
Date: Wed, 26 Nov 2025 12:29:27 -0800
Message-ID: <20251126202927.2584874-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251126202927.2584874-1-ameryhung@gmail.com>
References: <20251126202927.2584874-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

file_alloc_security hook is disabled. Use other LSM hooks in selftests
instead.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/test_lsm.c | 2 +-
 tools/testing/selftests/bpf/progs/lsm_tailcall.c  | 8 ++++----
 tools/testing/selftests/bpf/progs/verifier_lsm.c  | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_lsm.c b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
index 2a27f3714f5c..bdc4fc06bc5a 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_lsm.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
@@ -139,7 +139,7 @@ static void test_lsm_tailcall(void)
 	if (CHECK_FAIL(!err))
 		goto close_prog;
 
-	prog_fd = bpf_program__fd(skel->progs.lsm_file_alloc_security_prog);
+	prog_fd = bpf_program__fd(skel->progs.lsm_kernfs_init_security_prog);
 	if (CHECK_FAIL(prog_fd < 0))
 		goto close_prog;
 
diff --git a/tools/testing/selftests/bpf/progs/lsm_tailcall.c b/tools/testing/selftests/bpf/progs/lsm_tailcall.c
index 49c075ce2d4c..6e7e58051e64 100644
--- a/tools/testing/selftests/bpf/progs/lsm_tailcall.c
+++ b/tools/testing/selftests/bpf/progs/lsm_tailcall.c
@@ -20,14 +20,14 @@ int lsm_file_permission_prog(void *ctx)
 	return 0;
 }
 
-SEC("lsm/file_alloc_security")
-int lsm_file_alloc_security_prog(void *ctx)
+SEC("lsm/kernfs_init_security")
+int lsm_kernfs_init_security_prog(void *ctx)
 {
 	return 0;
 }
 
-SEC("lsm/file_alloc_security")
-int lsm_file_alloc_security_entry(void *ctx)
+SEC("lsm/kernfs_init_security")
+int lsm_kernfs_init_security_entry(void *ctx)
 {
 	bpf_tail_call_static(ctx, &jmp_table, 0);
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm.c b/tools/testing/selftests/bpf/progs/verifier_lsm.c
index 32e5e779cb96..6af9100a37ff 100644
--- a/tools/testing/selftests/bpf/progs/verifier_lsm.c
+++ b/tools/testing/selftests/bpf/progs/verifier_lsm.c
@@ -4,7 +4,7 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
-SEC("lsm/file_alloc_security")
+SEC("lsm/file_permission")
 __description("lsm bpf prog with -4095~0 retval. test 1")
 __success
 __naked int errno_zero_retval_test1(void *ctx)
@@ -15,7 +15,7 @@ __naked int errno_zero_retval_test1(void *ctx)
 	::: __clobber_all);
 }
 
-SEC("lsm/file_alloc_security")
+SEC("lsm/file_permission")
 __description("lsm bpf prog with -4095~0 retval. test 2")
 __success
 __naked int errno_zero_retval_test2(void *ctx)
-- 
2.47.3


