Return-Path: <bpf+bounces-21294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD4284AFBE
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 09:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85960B2402C
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 08:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7D012AAF9;
	Tue,  6 Feb 2024 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHyU+/AV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFDD12AAD6
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207337; cv=none; b=bnmyg4be6oyArcF7sTzFYzRxE4Ua3mdb176Mr+Rg6oVMbLzmwrRH6P8ItsrMAcMgsfG9aBPlURQusOPEsAh5XZjwexln4mGympT3on4kfWlZVb3OWk2YIivgn220DWAgY3INnfkFfewhkd1444FE+z6FJUUt0O5h50PQQ3g9Xr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207337; c=relaxed/simple;
	bh=p5YFwt0lznO99LnlPO06tkVy3LwCT7E4VX2YIZDl7io=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cSeC9w8DMctHNXtJErmiBAsWqIK8BmVEHAcjIKz7rrEo/YtSNUor0jhWdFGxWT5cCuLhKCTMLdU+Gh5OC4AZ7bvzZQI7RfNep+zHNH7dWu+b8Am1w6dGN2yd6JbIHTvMGt3P3Cm/AZsrEUDT42i3oY++9iJH+dF6CrnH8ZpCrg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHyU+/AV; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2191dc7079aso2045774fac.0
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 00:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707207335; x=1707812135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QL9q0Nn+JwZ83eKfz6uVxGQth1YMygFDcsBkZ2eKrxg=;
        b=BHyU+/AVD4OYOspQ60auP3xOpRa5+4G8N34SM+WEoLIDLUY+NrQpYimpSfvitw5xhh
         YwUwoCP9s85XOm4TfQWrYITYwYhlHkRYC4s++/F99xVpSPZqLzG5VWc9PqaI0SRHlQ59
         aF6uwqTLYKWKsN2Vp5WMdJkHAG/Vpa4oG4jsRDdIiBztmJZAgUmwMUTPaJRq9GhM5TEa
         c9KHHEZQI7+Hz4OCzpxPa5vQNKc1Ptut3Z/bzY3ji2HKs1qvy8QD+cQCgN4c1MalCsnk
         RxXSPOZIujmGLFwoqOgknSMsSvH+wWc3tFPgX99e6XKD/7nmf3+JBOOtUIiePnjsIAJ6
         ZaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707207335; x=1707812135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QL9q0Nn+JwZ83eKfz6uVxGQth1YMygFDcsBkZ2eKrxg=;
        b=QSld6BdBxYYpD1x6y0Yi1SNNiyLsxmj98KxFkpypGFblvGm6YHcew4F4Z8Y9Cuyayn
         vhG13pfVvS+kj+O7SNpHBcBAWZx6LE0lb1+NrD5Nmr4Yxj99HEIpVLW1jjd9f7gQIjm3
         Ar4m0qru7+dqamaTlJTP/H5Ab2sCxuOTzn/SRnmM7iy5byfgdWSKOxnDmpwQHBbab4jb
         8dgWXRwbozQwXoFFREb706Gbc2i58ycBYINghLPujS+Zfncwzlaqkq0gpQL+o1uGcnYg
         esiZzAgw1AERc/zuw/kdv48zY3PdCIieeKkNefdvQG9g3UKzjnGWMORuLc0rVdO9dmnw
         WPTw==
X-Gm-Message-State: AOJu0YydxKg15aaMisIIabBwjQNlZHHSjPi/8+qYJ9vFzh/D7McVTr86
	/liH6Gsn67gwbmtEPaliBkRRebXLBP+DPlRoGjccQnYMp18OmnNflrzaaw6pFfNcNBNH
X-Google-Smtp-Source: AGHT+IEMS9uSc3To3FVB7L0i/D8fiaMIl8NGdBvSdD35j7TIc/83xDoOVxGlR55ML+vCi3+dyyotig==
X-Received: by 2002:a05:6870:7e0b:b0:214:fcc4:e384 with SMTP id wx11-20020a0568707e0b00b00214fcc4e384mr1884751oab.15.1707207335000;
        Tue, 06 Feb 2024 00:15:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU/mRHgyoiWYApAsfbCpTHDeesost37V0bsorPA+a4q1pIJdUsfd1FKgPOpk8Jb6clmqyXm1qw8p/RdJl0PBv7iyqS1DUL65uEZdGC1NvjHx7s2uKoi97/0qBINJ8oTE9RxlffPHKEda/wjbYv3HkMK4mA0OnUYWAHrLqSRd3duwSDuid9c83DLLhd6c54cZy3DsQDpidLKhcVUILRFu30Z/2PT5T73B99W6iKOgbGpC/TdXCUgA3JtUHalt21VW5D1oI8ocrn9zou8KPhJd4ywC2QHqEeAXQt1CnXwxq1ZtcSWm+OH8asJkJDMgZSYRI46/Fos098QLKII4FGjOU0yu+6JeS3b+aanaypc/e3zKPGmQEewq0TVB8Kb9q8tfzycL4wRGz+UlP4zmQYhHRlfC++aAzP2wpZe012CGvjcEKvj6imnup1YsrGUCqOE1SCyn++fwW9l7SFr8XZDVu3NTs6Jo9a4rw2NEPtJ/r0ucg==
Received: from localhost.localdomain ([39.144.105.129])
        by smtp.gmail.com with ESMTPSA id 3-20020a630c43000000b005d7c02994c4sm1381660pgm.60.2024.02.06.00.15.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Feb 2024 00:15:34 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org,
	void@manifault.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Daniel Xu <dxu@dxuuu.xyz>
Subject: [PATCH v6 bpf-next 4/5] selftests/bpf: Mark cpumask kfunc declarations as __weak
Date: Tue,  6 Feb 2024 16:14:15 +0800
Message-Id: <20240206081416.26242-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240206081416.26242-1-laoar.shao@gmail.com>
References: <20240206081416.26242-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the series "Annotate kfuncs in .BTF_ids section"[0], kfuncs can be
generated from bpftool. Let's mark the existing cpumask kfunc declarations
__weak so they don't conflict with definitions that will eventually come
from vmlinux.h.

[0]. https://lore.kernel.org/all/cover.1706491398.git.dxu@dxuuu.xyz

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/progs/cpumask_common.h      | 57 ++++++++++---------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools/testing/selftests/bpf/progs/cpumask_common.h
index 0cd4aebb97cf..c705d8112a35 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_common.h
+++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
@@ -23,41 +23,42 @@ struct array_map {
 	__uint(max_entries, 1);
 } __cpumask_map SEC(".maps");
 
-struct bpf_cpumask *bpf_cpumask_create(void) __ksym;
-void bpf_cpumask_release(struct bpf_cpumask *cpumask) __ksym;
-struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask) __ksym;
-u32 bpf_cpumask_first(const struct cpumask *cpumask) __ksym;
-u32 bpf_cpumask_first_zero(const struct cpumask *cpumask) __ksym;
+struct bpf_cpumask *bpf_cpumask_create(void) __ksym __weak;
+void bpf_cpumask_release(struct bpf_cpumask *cpumask) __ksym __weak;
+struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask) __ksym __weak;
+u32 bpf_cpumask_first(const struct cpumask *cpumask) __ksym __weak;
+u32 bpf_cpumask_first_zero(const struct cpumask *cpumask) __ksym __weak;
 u32 bpf_cpumask_first_and(const struct cpumask *src1,
-			  const struct cpumask *src2) __ksym;
-void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask) __ksym;
-void bpf_cpumask_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask) __ksym;
-bool bpf_cpumask_test_cpu(u32 cpu, const struct cpumask *cpumask) __ksym;
-bool bpf_cpumask_test_and_set_cpu(u32 cpu, struct bpf_cpumask *cpumask) __ksym;
-bool bpf_cpumask_test_and_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask) __ksym;
-void bpf_cpumask_setall(struct bpf_cpumask *cpumask) __ksym;
-void bpf_cpumask_clear(struct bpf_cpumask *cpumask) __ksym;
+			  const struct cpumask *src2) __ksym __weak;
+void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask) __ksym __weak;
+void bpf_cpumask_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask) __ksym __weak;
+bool bpf_cpumask_test_cpu(u32 cpu, const struct cpumask *cpumask) __ksym __weak;
+bool bpf_cpumask_test_and_set_cpu(u32 cpu, struct bpf_cpumask *cpumask) __ksym __weak;
+bool bpf_cpumask_test_and_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask) __ksym __weak;
+void bpf_cpumask_setall(struct bpf_cpumask *cpumask) __ksym __weak;
+void bpf_cpumask_clear(struct bpf_cpumask *cpumask) __ksym __weak;
 bool bpf_cpumask_and(struct bpf_cpumask *cpumask,
 		     const struct cpumask *src1,
-		     const struct cpumask *src2) __ksym;
+		     const struct cpumask *src2) __ksym __weak;
 void bpf_cpumask_or(struct bpf_cpumask *cpumask,
 		    const struct cpumask *src1,
-		    const struct cpumask *src2) __ksym;
+		    const struct cpumask *src2) __ksym __weak;
 void bpf_cpumask_xor(struct bpf_cpumask *cpumask,
 		     const struct cpumask *src1,
-		     const struct cpumask *src2) __ksym;
-bool bpf_cpumask_equal(const struct cpumask *src1, const struct cpumask *src2) __ksym;
-bool bpf_cpumask_intersects(const struct cpumask *src1, const struct cpumask *src2) __ksym;
-bool bpf_cpumask_subset(const struct cpumask *src1, const struct cpumask *src2) __ksym;
-bool bpf_cpumask_empty(const struct cpumask *cpumask) __ksym;
-bool bpf_cpumask_full(const struct cpumask *cpumask) __ksym;
-void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src) __ksym;
-u32 bpf_cpumask_any_distribute(const struct cpumask *src) __ksym;
-u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1, const struct cpumask *src2) __ksym;
-u32 bpf_cpumask_weight(const struct cpumask *cpumask) __ksym;
-
-void bpf_rcu_read_lock(void) __ksym;
-void bpf_rcu_read_unlock(void) __ksym;
+		     const struct cpumask *src2) __ksym __weak;
+bool bpf_cpumask_equal(const struct cpumask *src1, const struct cpumask *src2) __ksym __weak;
+bool bpf_cpumask_intersects(const struct cpumask *src1, const struct cpumask *src2) __ksym __weak;
+bool bpf_cpumask_subset(const struct cpumask *src1, const struct cpumask *src2) __ksym __weak;
+bool bpf_cpumask_empty(const struct cpumask *cpumask) __ksym __weak;
+bool bpf_cpumask_full(const struct cpumask *cpumask) __ksym __weak;
+void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src) __ksym __weak;
+u32 bpf_cpumask_any_distribute(const struct cpumask *src) __ksym __weak;
+u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1,
+				   const struct cpumask *src2) __ksym __weak;
+u32 bpf_cpumask_weight(const struct cpumask *cpumask) __ksym __weak;
+
+void bpf_rcu_read_lock(void) __ksym __weak;
+void bpf_rcu_read_unlock(void) __ksym __weak;
 
 static inline const struct cpumask *cast(struct bpf_cpumask *cpumask)
 {
-- 
2.39.1


