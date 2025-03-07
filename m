Return-Path: <bpf+bounces-53535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7636DA55F4A
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 05:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D601704FB
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 04:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C982B192B81;
	Fri,  7 Mar 2025 04:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="tf8m70e7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDB618FDDF
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 04:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741321067; cv=none; b=rpXd3PJEaQ6xIckZSyRKi5+l+ZeevaFG5AD309zz7UdLDmUa9GkZPhp7ewPZQ7OfYCpErXEG08uRBnznMzIc8enct+JIQr/n+62Ev7xsDOCydwFNFCqD4STkBn2RDJf6OUxN+ZI3KpWBU466ZTwmA+FnuofROfdCpFHEAhrlkE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741321067; c=relaxed/simple;
	bh=yoOB3XBAUFWLJl/+mhpsMsnVbIGA2WEJ3UCxQBXv/pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7kaSw19Xs1tZKhmp4w/7iL5orp0nxcr/I9Xed7BvkNqzxFmMLS5K2ZXUJn2Bwizx+5XtOWw7nMXkQ1QZhaqyj2jS2EqCqiE486n89w+sFmwOdhHCdK+/j5dCZA7nrX/aSO6swkFABWAOTzpekfHvGkedWV6KbHZMCbgq+HWty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=tf8m70e7; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c08b14baa9so136020785a.3
        for <bpf@vger.kernel.org>; Thu, 06 Mar 2025 20:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741321064; x=1741925864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysk8uSizI198pwDNFtWduhkixI8nyvj/TN+YYY0BGnE=;
        b=tf8m70e7m+E/z2pI14czSaE1jrXQ6Rj9cFl1RVDjN5g4sR9pKmfNJzOk64QmfXGVhy
         n5dDiS7TA1JQLJYwT75UtB/SVhQc1BqgmP3gHLZlbm9ub1ck/MFq1kud+cgE8tFJUQfk
         Bksknw98T3zXCx6S2XnqcIG+FTkqHrWDjHmwFqxb5IytWVvKzTT8Qx/fDCGAcZtu1qgy
         rXMUHJf8axoYilNee/W3J5UDe5vbtBXkIUXeabLNnNGDh09pBA1YQjaejkWk/IIjO9dc
         QTizNQkPHgBUVxdWIc9V1/Lzw3FEt9BU28UfgOSdzu1U3UeOkQhe/TsXDBYxMYfxYzf8
         VDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741321064; x=1741925864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysk8uSizI198pwDNFtWduhkixI8nyvj/TN+YYY0BGnE=;
        b=iuNXJNAiXgb6ziZqdhe9fIUvJhcvBsmuwjPIDdneFLGCNel9vh0X8MVkJ537JdktBB
         7XpnYt9Ww/Ia73kKfcu52FcYnmD2VQ3Tg1oOGxlKby8u7afc9+ArcMJrh6xquiyCp2b+
         Sn0jU69p5xPQTlYuQESpsqeq+G3GqiE8H1svk82dcRIvSQnqK1v/HZK94D7i7T0uC38I
         Y9XNO4l0c7SjHVPhJ/oHTYvfilWG4KuhTDGDgPKd2Bx3aUBWLsOSr2YtPYdjQRtLiU00
         qDGJXiOezfbclsy/KIf/meYefm6KMq6o7b9ZVuRyoYZzxLACITDJJokFqYA8zTMU5OPy
         ZgpQ==
X-Gm-Message-State: AOJu0Yzj/5c396FU9rruMpOHKyJtC4yi9l1bg5y4c/Zy99Pth4nD4hUV
	/EHvAUAG56dKhS3msIJV950APSoxlYBwKiNulx4vIrB6cclH+mRrD0Q4eoQdth5FACSxGNqZm3B
	FbAOOIQ==
X-Gm-Gg: ASbGncvi6tkysHTKUbQQrKNfPHw16cSN5t/bKZB/wW2KVVYeQyGjtjVTu647b5ANLGs
	28QHEMU8y1onWfSXTQdz3Ez4PDjlM8IQi7ux7wSgWBKi+z3HURYWNvQg2dyCTPkV9kstCJarGdr
	SSkWHskFW3BLyrmhl/8zdI6ju/BZmuVLCg4dG1LSsbUGjP8Gn2FM+9g4UskFJ/FOJ9CsDO05hyZ
	dEU16ftkW+WVocmTAoyWMRMzuf3CDsdZq5RgHG36seKqmhrSaJYgv2tJ/wM7QiEEXovMTG8iFtJ
	B3l5ltcV2Di90O2Ggm+h+bykBBh+rkw2U6GGN0+RYA==
X-Google-Smtp-Source: AGHT+IFNAERyWPisIpQ5LXZbWMPq/B3ycSGtAxfFqyXRpDxX6+N+9uuZ8b7mXwkury/iu+YagWPmBw==
X-Received: by 2002:a05:620a:2787:b0:7c3:c199:c3b0 with SMTP id af79cd13be357-7c4e610578fmr332020085a.32.1741321064056;
        Thu, 06 Mar 2025 20:17:44 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e534ba85sm186108085a.28.2025.03.06.20.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 20:17:43 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	memxor@gmail.com,
	houtao@huaweicloud.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v5 4/4] selftests: bpf: add missing cpumask test to runner and annotate existing tests
Date: Thu,  6 Mar 2025 23:17:38 -0500
Message-ID: <20250307041738.6665-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307041738.6665-1-emil@etsalapatis.com>
References: <20250307041738.6665-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF cpumask selftests are supposed to be run twice, once to ensure
that they load properly and once to actually test their behavior. The
load test is triggered by annotating the tests with __success, while the
run test needs adding to tools/testing/selftests/bpf/prog_tests/cpumask.c
the name of the new test. However, most existing tests are missing the
__success annotation, and test_refcount_null_tracking is missing from the
main test file. Add the missing annotations and test name.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 .../testing/selftests/bpf/prog_tests/cpumask.c |  1 +
 .../selftests/bpf/progs/cpumask_success.c      | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
index 9b09beba988b..447a6e362fcd 100644
--- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
+++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
@@ -25,6 +25,7 @@ static const char * const cpumask_success_testcases[] = {
 	"test_global_mask_nested_deep_rcu",
 	"test_global_mask_nested_deep_array_rcu",
 	"test_cpumask_weight",
+	"test_refcount_null_tracking",
 	"test_populate_reject_small_mask",
 	"test_populate_reject_unaligned",
 	"test_populate",
diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index 51f3dcf8869f..8abae7a59f92 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -136,6 +136,7 @@ static bool create_cpumask_set(struct bpf_cpumask **out1,
 }
 
 SEC("tp_btf/task_newtask")
+__success
 int BPF_PROG(test_alloc_free_cpumask, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *cpumask;
@@ -152,6 +153,7 @@ int BPF_PROG(test_alloc_free_cpumask, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
+__success
 int BPF_PROG(test_set_clear_cpu, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *cpumask;
@@ -181,6 +183,7 @@ int BPF_PROG(test_set_clear_cpu, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
+__success
 int BPF_PROG(test_setall_clear_cpu, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *cpumask;
@@ -210,6 +213,7 @@ int BPF_PROG(test_setall_clear_cpu, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
+__success
 int BPF_PROG(test_first_firstzero_cpu, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *cpumask;
@@ -249,6 +253,7 @@ int BPF_PROG(test_first_firstzero_cpu, struct task_struct *task, u64 clone_flags
 }
 
 SEC("tp_btf/task_newtask")
+__success
 int BPF_PROG(test_firstand_nocpu, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *mask1, *mask2;
@@ -281,6 +286,7 @@ int BPF_PROG(test_firstand_nocpu, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
+__success
 int BPF_PROG(test_test_and_set_clear, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *cpumask;
@@ -313,6 +319,7 @@ int BPF_PROG(test_test_and_set_clear, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
+__success
 int BPF_PROG(test_and_or_xor, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *mask1, *mask2, *dst1, *dst2;
@@ -360,6 +367,7 @@ int BPF_PROG(test_and_or_xor, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
+__success
 int BPF_PROG(test_intersects_subset, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *mask1, *mask2, *dst1, *dst2;
@@ -402,6 +410,7 @@ int BPF_PROG(test_intersects_subset, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
+__success
 int BPF_PROG(test_copy_any_anyand, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *mask1, *mask2, *dst1, *dst2;
@@ -456,6 +465,7 @@ int BPF_PROG(test_copy_any_anyand, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
+__success
 int BPF_PROG(test_insert_leave, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *cpumask;
@@ -471,6 +481,7 @@ int BPF_PROG(test_insert_leave, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
+__success
 int BPF_PROG(test_insert_remove_release, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *cpumask;
@@ -501,6 +512,7 @@ int BPF_PROG(test_insert_remove_release, struct task_struct *task, u64 clone_fla
 }
 
 SEC("tp_btf/task_newtask")
+__success
 int BPF_PROG(test_global_mask_rcu, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *local, *prev;
@@ -534,6 +546,7 @@ int BPF_PROG(test_global_mask_rcu, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
+__success
 int BPF_PROG(test_global_mask_array_one_rcu, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *local, *prev;
@@ -632,12 +645,14 @@ static int _global_mask_array_rcu(struct bpf_cpumask **mask0,
 }
 
 SEC("tp_btf/task_newtask")
+__success
 int BPF_PROG(test_global_mask_array_rcu, struct task_struct *task, u64 clone_flags)
 {
 	return _global_mask_array_rcu(&global_mask_array[0], &global_mask_array[1]);
 }
 
 SEC("tp_btf/task_newtask")
+__success
 int BPF_PROG(test_global_mask_array_l2_rcu, struct task_struct *task, u64 clone_flags)
 {
 	return _global_mask_array_rcu(&global_mask_array_l2[0][0], &global_mask_array_l2[1][0]);
@@ -670,6 +685,7 @@ int BPF_PROG(test_global_mask_nested_rcu, struct task_struct *task, u64 clone_fl
  * incorrect offset.
  */
 SEC("tp_btf/task_newtask")
+__success
 int BPF_PROG(test_global_mask_nested_deep_rcu, struct task_struct *task, u64 clone_flags)
 {
 	int r, i;
@@ -689,6 +705,7 @@ int BPF_PROG(test_global_mask_nested_deep_rcu, struct task_struct *task, u64 clo
 }
 
 SEC("tp_btf/task_newtask")
+__success
 int BPF_PROG(test_global_mask_nested_deep_array_rcu, struct task_struct *task, u64 clone_flags)
 {
 	int i;
@@ -706,6 +723,7 @@ int BPF_PROG(test_global_mask_nested_deep_array_rcu, struct task_struct *task, u
 }
 
 SEC("tp_btf/task_newtask")
+__success
 int BPF_PROG(test_cpumask_weight, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *local;
-- 
2.47.1


