Return-Path: <bpf+bounces-74670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 040A1C60E9D
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 02:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 584634E21A5
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 01:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6417217F2E;
	Sun, 16 Nov 2025 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4U8zbLZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29BC1E5B88
	for <bpf@vger.kernel.org>; Sun, 16 Nov 2025 01:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763257373; cv=none; b=E2y7/HsrK06yGSfvOn7IPd22gG8yScUvR6T3tbVJRTsO40eNrujYYYyOGIqipRzwH+HZx9vG6fztmT3kPY7SoprXSPIGF2Vt1S7ykDDzx9iJfFFwBwuk6bMHkaxNZYsKve+vCRRFCjesvhzcG1vfBn5rYftXFyMzj0yc1byhqx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763257373; c=relaxed/simple;
	bh=qYNdzOMrVfyqOsFIUuLtig4HQ4c3gJxVv6JUEuRa8uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=meuW/CTQHTrj5kkRv5nDFqDd/rK0qd7addbaRDp6dfKZbrD9tGadIXbTshMamVIxRcmwizMRDs8R8AMUQp5VZPxuJtebdGhY8+PF9tWK+73oR6eT0STHpW/laD5SMbmpOxmuSO5QxCiFG2dfaRm8XIJ3ebm5QbW3LJ9I9jbMd6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4U8zbLZ; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-3438d4ae152so4088916a91.1
        for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 17:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763257371; x=1763862171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FAy9YPVCu7bLfM4qk+fenh6vAk3C+JyPIshXGIHtStU=;
        b=g4U8zbLZsOmhccacd4609clPw5cpQtgJRp1jR58mkCMPXJh5DCw6MNawZhv8s20fBl
         ELbqErx/O8J1VC/hFOv0lvLN3xH8CHdcAya80HwP9Id5zqziXYUfWS4GDVD6/YoELprK
         TQGiZowMk91CigMdXrhWqQ0H3rdCF6CDcBVrsC1JDN5RN2Nz98kRz/9j2wdT4HRTF9Wl
         khrGnGJD7FkG8HfHzAYIUptsZBgfuvf7womsSjr03ucn0YSLtHKYgiDTEFvLFC0E8GME
         mXWk4VV16lFgh6b10puD3Lq+Y6Z2wFienLvXNsc5DkL/8U6roIaksuHIRuVnZXf4VpCw
         G6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763257371; x=1763862171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAy9YPVCu7bLfM4qk+fenh6vAk3C+JyPIshXGIHtStU=;
        b=iDDrTM4S0F8VzDgCR/p5BOF23dl5DMMQziK4s0EKEIjtWs18EUCedBJPGtpXWfJud9
         lu1Ff8BCD6WHWkNftZO+xWlcUN32Neh2fKMuLDkKIcoWORJPjRQqpJzBnHX340J3WDQ8
         2zTk/YapMkgqyVfopLBWYhofzKaE0C0PQgOUmNSf3cE/+cfHGmx5LgKiUTUokYpqhCcU
         cMldMbenCbRJgB4mMQkgcMsA9sOSbMzbjNiOUSmDfqaEY0X9b9NH1EnigJSmOfTmtFkF
         nokhmUtdyK4Ax6JzfgBxbbp1ktqvSKbzsATHLBNqAPzDLjE0tSxe5Bzqb2qs/yhOvA32
         UPEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+wJUZx4Ou4HQNUYRmRXof5LM3dYgiQBTnuIseOZwBBRIjQgYZP87azgHbun6Lo96xjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YziyhGLBeTpNSVX7AQfAnmmGKY9KvvifSRUg9xEgPMFg4dmAajp
	0zkr2qWfJ/M/KAGeJWF3cuyc4gCWrwW+rzZq4IQtAReIsNDkwj8rkwoU
X-Gm-Gg: ASbGncun+K6NVZl5MJHObGjQzv471XBoxChHnG0Bl6Osv60iCS2Q1Jn9Z6eRWMeK+C6
	akp7Ug73RFq6krv6edx+l0LrIcVxSJEq9iGa0OduExPhq4MguDdvr8LYfdntbjat32dj+tuohin
	seU9YtHwDQA1eQFH4hotcVZl2eRDA2+rG4fQZA47JccruRItO1c64n1aLTsvy1y4GEEejJLbAXG
	Ma5R1lexohAiZ0A/hF0ZHRz7PHbrRv0vZLyupWUQSw8wwlKAh+Bzxe2jeQH4CHPhZ1eDTDxrfhB
	cgBnZkA/5rzdD8vUZIt40dZNieBWDXwud+m66pLMU+vHTvY4Hc8LfZ5xJwS3zBGx2Ca/dKmKJ6L
	XAqmlhXDwrGH3GTf9bmD1LiJ+46/mkvzdO9AGdlEKTFOZ5sotFbI4nY7C82tW8AXMY8UvUoKHcK
	9+
X-Google-Smtp-Source: AGHT+IHwMTm+3w4Hi6aGuV3EFYma9rpYV2hO6neS7/j59k0gNdUR5jovUBVjsn0Kg939TBxdL+1jaQ==
X-Received: by 2002:a17:90b:2f08:b0:33b:dec9:d9aa with SMTP id 98e67ed59e1d1-343fa7493admr8502869a91.25.1763257371056;
        Sat, 15 Nov 2025 17:42:51 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36f61bea9sm8243757a12.14.2025.11.15.17.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 17:42:50 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	mingo@kernel.org,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: call bpf_get_numa_node_id() in trigger_count()
Date: Sun, 16 Nov 2025 09:42:42 +0800
Message-ID: <20251116014242.151110-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bench test "trig-kernel-count" can be used as a baseline comparison
for fentry and other benchmarks, and the calling to bpf_get_numa_node_id()
should be considered as composition of the baseline. So, let's call it in
trigger_count(). Meanwhile, rename trigger_count() to
trigger_kernel_count() to make it easier understand.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/testing/selftests/bpf/benchs/bench_trigger.c | 4 ++--
 tools/testing/selftests/bpf/progs/trigger_bench.c  | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 1e2aff007c2a..34018fc3927f 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -180,10 +180,10 @@ static void trigger_kernel_count_setup(void)
 {
 	setup_ctx();
 	bpf_program__set_autoload(ctx.skel->progs.trigger_driver, false);
-	bpf_program__set_autoload(ctx.skel->progs.trigger_count, true);
+	bpf_program__set_autoload(ctx.skel->progs.trigger_kernel_count, true);
 	load_ctx();
 	/* override driver program */
-	ctx.driver_prog_fd = bpf_program__fd(ctx.skel->progs.trigger_count);
+	ctx.driver_prog_fd = bpf_program__fd(ctx.skel->progs.trigger_kernel_count);
 }
 
 static void trigger_kprobe_setup(void)
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 3d5f30c29ae3..2898b3749d07 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -42,12 +42,14 @@ int bench_trigger_uprobe_multi(void *ctx)
 const volatile int batch_iters = 0;
 
 SEC("?raw_tp")
-int trigger_count(void *ctx)
+int trigger_kernel_count(void *ctx)
 {
 	int i;
 
-	for (i = 0; i < batch_iters; i++)
+	for (i = 0; i < batch_iters; i++) {
 		inc_counter();
+		bpf_get_numa_node_id();
+	}
 
 	return 0;
 }
-- 
2.51.2


