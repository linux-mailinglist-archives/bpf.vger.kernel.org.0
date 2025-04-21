Return-Path: <bpf+bounces-56320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA536A9556E
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 19:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05AD0173668
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 17:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925B71E5B6A;
	Mon, 21 Apr 2025 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnjmrFuw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F202F3E
	for <bpf@vger.kernel.org>; Mon, 21 Apr 2025 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745257455; cv=none; b=g15Ci68oDI4fbhRkVHv94qhz3JeQADrZff9IB8RmF+erZRvGdHPOtLlClmoUobN3Pra3E/SkNnWROvmRpura99nFWX3bGg9p4ovGpRcUj1qpmmfvtxehc70PuZDas1i9ry0Akm4poeqWFzwbKLPemB7gw5ym2Y4sZmNjepzdRkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745257455; c=relaxed/simple;
	bh=Y3ZEz6kcPZGieiyNmVJvxEZSi2ZZRlk88a7+rPAs1oA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h2940DsrxOHg+mx2Y8u0JaJlShR2B2oVCzA//4emOeojlD1kCKxKE8vNfuUuMt5l/JDj1RLuvPGLdbqS6crLYM2T/ciJZo03brX2mI/G9lyVyiBGxBTVYYJqybw5zy5S3Di0Igc3vZB/keEGvjWmGdJxQWqDZ+oMB/bm7eJnzyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnjmrFuw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7370a2d1981so3371166b3a.2
        for <bpf@vger.kernel.org>; Mon, 21 Apr 2025 10:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745257453; x=1745862253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nShN0409dtapHAeX0L4ILysvxpF/FPLpDWe3d4DVeTs=;
        b=BnjmrFuwtw0Uncbr/ZPSZLGx40K86rzHNSn85RCMEMbSZtqbHiL3aJPyoaznf16stM
         ctpJNnTGV0+a3DrQxIv8FD16LuJSL80IHbg/OSZv+yPj3shdh7kJ85T0lG/d/hSzA5PP
         XKHdcmqBehPSLABoU2Ci0Ipml1GroGx9SZHvdAR6MmOKH/0aq96TLfK7UB+jgLB/AGWA
         fgOTTFu4xIIJtdpWzjT5pj93Ngku00PyDNBp4K+mWdWoTIzhX66L+0m5EomFi4RIys3i
         PIfv+tuRz+gwCR7k/ahnWsxZBKC+9+zfgE2tXHcVScX7ZPVSxTAWmKRUMmu/lWfm7xYM
         5OoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745257453; x=1745862253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nShN0409dtapHAeX0L4ILysvxpF/FPLpDWe3d4DVeTs=;
        b=jYI5MukG+3nHif67kH8LeNzqXZNjvu37+LntGDExf2iCi/Ie1WFPFXtjLrNWzMLunY
         JBqI7Etxf6CNtq/HCpY42Euxz249y/ws4MJUcLWfH4hizlkWe1UzAhBIGjqQ0f8lM/aC
         eeWkDsdBogVU/46rz6JRldyUQ0hcSYmG+jChXN82F1B3wYFDD2LqMUdZdIL/2SH/eOLW
         epfHC7bW7eG4b+v2qvdpuoTbpW08dzzoYqT/bV4UXX4rwAvrK4KNThh1MTbNJJ5iyD+k
         Dxzoy/qfhPn0/DX+r6IifydUIh0pkCi8dEuuEbm+aKsssHopSsF8h5g0gdJLkjAqmqvZ
         O0HQ==
X-Gm-Message-State: AOJu0YzDIGWDK57FvUKTNmYmYEPEmUkCxPOpDLBksT01Wcj1wuLB66iC
	tN6W9bjcsnADgKfH6C9MMOAgp0oiQEvGdBAmvpBOeZey+CElPyikYXnr2F3C
X-Gm-Gg: ASbGnctrnHsF+x6i9NfUEoGEv/0bCY2xbriF8Jxs8sQTwiltXLgqmIjTnGNXfSu/YdP
	4rFQ51BE5Qb6oYHI/CF5rkdHCV6J18jikov9APxPV98bIx/ukdUt0BjwQad7z50TPeYYt/g5iM4
	Vr5dbK683Drvv5T1Q8q7LbGeyJdRDPhg+1om8zs+aMfH+ErhCuZ6UfCShDtL+n2QuvoGyzKHaZx
	kzUWcMTUjIrsLFo2mx34/rqAEnWyNsjHRtPda6crh3AK/sfQEqeDLITo7VVUpwLQq4kkk8O0CtY
	oiifTVZ7x/zMd15L2mN8Uk7AhziuvPGBj41UIP4EQ1zXl3tHfCqsPapjsIE65f+b8TZ8O2SoW4f
	/e+9Xm/heH1n6
X-Google-Smtp-Source: AGHT+IExN8R2qGaKppOm7D+tFa2VIQjqb9Ykwq1eG40OGH9wVJf1UqkzKuJ0xr8AT8fwEdfghKEGAw==
X-Received: by 2002:a05:6a00:4484:b0:736:5725:59b4 with SMTP id d2e1a72fcca58-73dc14439f4mr15782010b3a.3.1745257452834;
        Mon, 21 Apr 2025 10:44:12 -0700 (PDT)
Received: from malayaVM.mrout-thinkpadp16vgen1.punetw6.csb ([106.215.151.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfa58871sm7158010b3a.102.2025.04.21.10.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 10:44:12 -0700 (PDT)
From: Malaya Kumar Rout <malayarout91@gmail.com>
To: andrii.nakryiko@gmail.com,
	alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	Malaya Kumar Rout <malayarout91@gmail.com>
Subject: [PATCH] selftests/bpf: close the file descriptor to avoid resource leaks
Date: Mon, 21 Apr 2025 23:14:05 +0530
Message-ID: <20250421174405.26080-1-malayarout91@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static analysis found an issue in bench_htab_mem.c and sk_assign.c

cppcheck output before this patch:
tools/testing/selftests/bpf/benchs/bench_htab_mem.c:284:3: error: Resource leak: fd [resourceLeak]
tools/testing/selftests/bpf/prog_tests/sk_assign.c:41:3: error: Resource leak: tc [resourceLeak]

cppcheck output after this patch:
No resource leaks found

Fix the issue by closing the file descriptors fd and tc.

Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
---
 tools/testing/selftests/bpf/benchs/bench_htab_mem.c | 3 +--
 tools/testing/selftests/bpf/prog_tests/sk_assign.c  | 4 +++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
index 926ee822143e..297e32390cd1 100644
--- a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
+++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
@@ -279,6 +279,7 @@ static void htab_mem_read_mem_cgrp_file(const char *name, unsigned long *value)
 	}
 
 	got = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
 	if (got <= 0) {
 		*value = 0;
 		return;
@@ -286,8 +287,6 @@ static void htab_mem_read_mem_cgrp_file(const char *name, unsigned long *value)
 	buf[got] = 0;
 
 	*value = strtoull(buf, NULL, 0);
-
-	close(fd);
 }
 
 static void htab_mem_measure(struct bench_res *res)
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 0b9bd1d6f7cc..10a0ab954b8a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -37,8 +37,10 @@ configure_stack(void)
 	tc = popen("tc -V", "r");
 	if (CHECK_FAIL(!tc))
 		return false;
-	if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc)))
+	if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc))) {
+		pclose(tc);
 		return false;
+	}
 	if (strstr(tc_version, ", libbpf "))
 		prog = "test_sk_assign_libbpf.bpf.o";
 	else
-- 
2.43.0


