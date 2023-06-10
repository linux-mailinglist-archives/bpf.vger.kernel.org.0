Return-Path: <bpf+bounces-2302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B4A72A8EC
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 05:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017E51C2117C
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 03:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3E36FA5;
	Sat, 10 Jun 2023 03:51:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5086763D1
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 03:51:04 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2143AA8;
	Fri,  9 Jun 2023 20:51:01 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-626190df842so19634526d6.0;
        Fri, 09 Jun 2023 20:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686369061; x=1688961061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fnYwuYaIS9dKMy4HedverGuGC//hnx9S7Ka8IPobdY=;
        b=UHI9aRy4+WIJFi0zmfDkpuONYdKhfEfQmPJfIs8lP2QbfWlbNIhQdvN5L6s0EHoPOu
         XMnBjUwgvOzxGejPJJOdeTT77Kihx7YSo0XzO6KcrDAadgJQ9WqRzDQVtcHs9lWEy4ZD
         q1hJU5l9quKMdzgTKE+OFy7sEHSoRGliHPTqeyDmA25SD6f1omaerx7sxMaIrA23TYxO
         R/xa0R0PwhWT0vL/bqIiC47a6DRzN6OiVAiCuTlDlw70aqm0IgyP3pS1CbtWQLYMla3w
         K5kjdZz17TMSFUjYpFmaSQt0Piaj1l3ecagVh9Fic5EN7/Y1anzqtMgQL7Sp5tzDgz5b
         nBNg==
X-Gm-Message-State: AC+VfDwY4ejrOANIqILDIiMwabiaPr3aMMo9tRdNGshs+O04gi7iiYZx
	keB+TUKOsWFNCskWXXW4rWSDWplH5qaLCV1f
X-Google-Smtp-Source: ACHHUZ5KdANU/goYfo/oTCEnOde3f+Emr+BVtvTKFmvkRmSiqfEcOmSlPVpPNZv6hQnEiQMLBSMf4A==
X-Received: by 2002:a05:6214:c2b:b0:621:3b88:7b09 with SMTP id a11-20020a0562140c2b00b006213b887b09mr3883590qvd.35.1686369060687;
        Fri, 09 Jun 2023 20:51:00 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:81d3])
        by smtp.gmail.com with ESMTPSA id t18-20020a0cea32000000b005ef54657ea0sm1588317qvp.126.2023.06.09.20.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 20:51:00 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	tj@kernel.org
Subject: [PATCH bpf-next 4/5] selftests/bpf: Update bpf_cpumask_any* tests to use bpf_cpumask_any_distribute*
Date: Fri,  9 Jun 2023 22:50:52 -0500
Message-Id: <20230610035053.117605-4-void@manifault.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610035053.117605-1-void@manifault.com>
References: <20230610035053.117605-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In a prior patch, we removed the bpf_cpumask_any() and
bpf_cpumask_any_and() kfuncs, and replaced them with
bpf_cpumask_any_distribute() and bpf_cpumask_any_distribute_and().
The advertised semantics between the two kfuncs were identical, with the
former always returning the first CPU, and the latter actually returning
any CPU.

This patch updates the selftests for these kfuncs to use the new names.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/bpf/progs/cpumask_common.h  | 4 ++--
 tools/testing/selftests/bpf/progs/cpumask_success.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools/testing/selftests/bpf/progs/cpumask_common.h
index b3493d5d263e..b15c588ace15 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_common.h
+++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
@@ -52,8 +52,8 @@ bool bpf_cpumask_subset(const struct cpumask *src1, const struct cpumask *src2)
 bool bpf_cpumask_empty(const struct cpumask *cpumask) __ksym;
 bool bpf_cpumask_full(const struct cpumask *cpumask) __ksym;
 void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src) __ksym;
-u32 bpf_cpumask_any(const struct cpumask *src) __ksym;
-u32 bpf_cpumask_any_and(const struct cpumask *src1, const struct cpumask *src2) __ksym;
+u32 bpf_cpumask_any_distribute(const struct cpumask *src) __ksym;
+u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1, const struct cpumask *src2) __ksym;
 
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index fbaf510f4ab5..674a63424dee 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -344,13 +344,13 @@ int BPF_PROG(test_copy_any_anyand, struct task_struct *task, u64 clone_flags)
 	bpf_cpumask_set_cpu(1, mask2);
 	bpf_cpumask_or(dst1, cast(mask1), cast(mask2));
 
-	cpu = bpf_cpumask_any(cast(mask1));
+	cpu = bpf_cpumask_any_distribute(cast(mask1));
 	if (cpu != 0) {
 		err = 6;
 		goto release_exit;
 	}
 
-	cpu = bpf_cpumask_any(cast(dst2));
+	cpu = bpf_cpumask_any_distribute(cast(dst2));
 	if (cpu < nr_cpus) {
 		err = 7;
 		goto release_exit;
@@ -362,13 +362,13 @@ int BPF_PROG(test_copy_any_anyand, struct task_struct *task, u64 clone_flags)
 		goto release_exit;
 	}
 
-	cpu = bpf_cpumask_any(cast(dst2));
+	cpu = bpf_cpumask_any_distribute(cast(dst2));
 	if (cpu > 1) {
 		err = 9;
 		goto release_exit;
 	}
 
-	cpu = bpf_cpumask_any_and(cast(mask1), cast(mask2));
+	cpu = bpf_cpumask_any_and_distribute(cast(mask1), cast(mask2));
 	if (cpu < nr_cpus) {
 		err = 10;
 		goto release_exit;
-- 
2.40.1


