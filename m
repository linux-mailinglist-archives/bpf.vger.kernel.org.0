Return-Path: <bpf+bounces-55823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B48B2A86EE8
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 20:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DFCE19E0263
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 18:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEA9230D0F;
	Sat, 12 Apr 2025 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jInvIMkE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F1B22F383
	for <bpf@vger.kernel.org>; Sat, 12 Apr 2025 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744483137; cv=none; b=pYn9njZDyOplBEPOOvvXEELZHs3yE+6OUMtThI1QPWHXkKAzQNX5JLpOfk7dAIgN+WwAdWQSO9yif6Ey8t0622m2WQ5RmnxieN347lr4MOiuFJ2lgsgY2u7MDS6dC24+PrJzWhDnP38/A0iBS4OZjhSk2ILjP/kNxgqaOvlUkyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744483137; c=relaxed/simple;
	bh=Y1CAUDfRPRqtZxcCYkMHcL+wqhTVZo+DEyVmNHtg2gU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jA482G4x5ErbEvuAmI2zbyGsVy/98HD15cjz7Ms7ZDZg/nZ5q6+eMuJTa1vy39QinKFUAtsJxqtqg7/UgKLoRnthRJyXZmpdzXUyOCJp+jUq2Qp1drzAnU6U1OQ5qY3K2ZvKdT/2LKmLmbXEkscxsSlDgSSszvqCxo45qnWAW9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jInvIMkE; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7359aca7ef2so4485241b3a.2
        for <bpf@vger.kernel.org>; Sat, 12 Apr 2025 11:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744483135; x=1745087935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fy8gQxv00CKM3uOQAjxaTXBjmWXaA1anLVVUJoKzsr8=;
        b=jInvIMkErImrgklwyaLj2sf7+suiSGkIHNzYQa2XlvPHi/3ntjOkygwIRAuEXSOaam
         T992PNgFrcnW3JqlIl7QJ4ljGRgoOg281p1SJumrc3m+NYjdCmSYhFl/fFsnLxKcn63R
         CPTW1VxQUt4FwLTFSO9plaRvCWXh2Brx++25Cn6QaHss97xGh6tASl5THPxxDP/D1BhI
         94KhkNv9CjkGVbev2YKwlLlB142VY4iEyMmZCZXpqGiNjrPCqAKo9YYhsioXJuvuk+6Y
         OyMk8wYCDjDrKJj/iQbIFWepsglsXoZc+pe3yMX+fckcZCMCQBgKcyEzdiakIFfIXzgg
         4mig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744483135; x=1745087935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fy8gQxv00CKM3uOQAjxaTXBjmWXaA1anLVVUJoKzsr8=;
        b=LHW08cBjS3VC2/srv64zSU9rL2cjKJlbzSN6QfkIsT95xxshkahcW+tf3YlwFX/B3F
         7l1EJLFNak3Gd2c/+pqGHDFNSK3Gx1pjqRzMERF50ozJhPBwQVL7u9LtGqa/DoQQOsaR
         XM1Z9LZ0Q8NVz7g7CaTXprz58rK2BUr9LZgDcdQrWVJq5pjdwCxogUtQFsJ03aXHQ30U
         i7kk7yjsg+TLWBDY39So2qYwjNRsbV2dUZ3ygCGnmZGbQvh0eIEpc8rFnvZjWOfEc2gL
         rhin0/hCAzmAHnfh7nknwtFJUs2XocYpSQPBcL9jy/JZjr/DoAhc8tNKP/YgNqeTzHpj
         JHiA==
X-Gm-Message-State: AOJu0YyGqHIDTJSWhA8Xc3o4/mUQhdK2GJ/8Lm64An9xz6DPxstcv/h/
	ZCwhdlJYJPTsn5Y6+0YbMffr+yBsms2W4iL4Pd/Z2JJ2586UQFTub/onzw==
X-Gm-Gg: ASbGncsysIullnJEPZQFQkr0kYEeZ3r3wp1G2527nvTOBCq2qQdtBX+IXnjao66CkGr
	ndOnilaexglgU3sKtpd/xji6UTtW5dMI+WRp9glcpG9E78neMUDMjcOZoG6XuM7CxC1EyHeUisN
	eyxL+YZHsr3kCw+s9Ywgmiy8hKJ4hfRyfRmEuZx7aNKC2oozMcZ13rO+dSFgURFhfVKBWNyAlmN
	bBiPSe3+zbMuuJdja2DAJ3JfjGMXHxNhxrOfMYnQNYexp3FZceZxHLiVt/3fmwKgVxxs8i80SMw
	F4q8s37XyacHacaoS0UuMUArm35U+zbKgvKgKtPyLMH7bF3btoQTHIjC+4Z5bWDndZSYOYx/kVi
	0EkVLsWyzQHXj1++lIVH6OlY=
X-Google-Smtp-Source: AGHT+IEZ+8obQLAY42wHbzuAIqfjhZqBQ9dwTY5lbgXECLCcldaC2M/j/3edKRxUwN4rp25XBOIE1Q==
X-Received: by 2002:a05:6a21:9994:b0:1f5:8c86:5e2f with SMTP id adf61e73a8af0-20179996509mr11439646637.37.1744483134999;
        Sat, 12 Apr 2025 11:38:54 -0700 (PDT)
Received: from malayaVM.mrout-thinkpadp16vgen1.punetw6.csb ([106.215.145.140])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0818248sm6777887a12.9.2025.04.12.11.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 11:38:54 -0700 (PDT)
From: Malaya Kumar Rout <malayarout91@gmail.com>
To: andrii.nakryiko@gmail.com,
	alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	Malaya Kumar Rout <malayarout91@gmail.com>
Subject: [PATCH] selftests/bpf: close the file descriptor to avoid resource leaks
Date: Sun, 13 Apr 2025 00:08:47 +0530
Message-ID: <20250412183847.9054-1-malayarout91@gmail.com>
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
index 0b9bd1d6f7cc..05cf66265cf1 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -37,8 +37,10 @@ configure_stack(void)
 	tc = popen("tc -V", "r");
 	if (CHECK_FAIL(!tc))
 		return false;
-	if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc)))
+	if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc))) {
+		close(tc);
 		return false;
+	}
 	if (strstr(tc_version, ", libbpf "))
 		prog = "test_sk_assign_libbpf.bpf.o";
 	else
-- 
2.43.0


