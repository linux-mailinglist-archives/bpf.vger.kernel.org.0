Return-Path: <bpf+bounces-28404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C508B90D2
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 22:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270CE1F22305
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 20:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A861635A9;
	Wed,  1 May 2024 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jL0WowwO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0012A165FA4
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596466; cv=none; b=fLwi3uiKEDt8zAHWcJVd25jZjtPNWMY4t+fjxCpn2MUIsC/0brFqOC9EttJjpCHAThn3Q+SkJjy1vqiGQtYvbZGO7hFY1sQd3eLC5b8d/xuYSS/zCQtycrYQeX0I8HobhVqeuu1sgwsFuIRR6+iXnphN0JGwbZffubJ/KOOSW7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596466; c=relaxed/simple;
	bh=Ma3Vu2MlOrX3+7gHJ0smej7Cz6EfF40UjlbMuQF7iyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eVV/Ie42CaDilFyUF5xofLwG5koW8zN5IlehkjvUvJe/ENKUq8JGC1qL7pC7VraMqAafOu8eXnU2Zsc96tQOljtxEneeEEaoYJc3mCUlEJeX1V5c2JfHKy3nGnO5/NkKAsbHltxyyEyHl7JTCuA1Hq75zTF2HjprMcZgYmHIrXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jL0WowwO; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-22edbef3b4eso1891662fac.3
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 13:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714596464; x=1715201264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEkoRMBGu2GwDIk9DvRSHZhuDVYyTKX9czbFcw2JQz8=;
        b=jL0WowwO7/laJ2nGqaNgnCOCHFXbXIYSDXMBbYKf4EQBgPigiTtbdE8Xi4HghE+RhV
         gYDEdg3Teux/uX71yQIgXmRaausBABxtfNB7rHfInm/ONA2Z9k/+v/PSncWXsfFA57Pg
         WZYuFXMq2Q5UtkBVCok6XNxuj9pt5SXKXLVq5GW8cQ3NPcovA2zeEiC8JLRhnjfXcuNK
         ZqM/A7s0MAbYlQY04DA8Tn6PFuRtvHU1BdAKiEK+eclWgt5LmgZ/uaWP99s6HTDMddNw
         Hvb97XoQjwyQ20Uo8IzPPZhA5HisQTRxS5mZMvYRujcKBROTQs0leu3214v9TUEzlfSA
         75sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714596464; x=1715201264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEkoRMBGu2GwDIk9DvRSHZhuDVYyTKX9czbFcw2JQz8=;
        b=lKYkrN6uu32zufCrWmSIOLkBGz1hVtpdo1I9Hy3yVueV4yu9LqEc0dqj8EP9S+O8An
         RXjiYVMAYJ3JGOUMuYZggkb5gk+ktaMTHTrvKen5y7UDqkH57zD/Ytl+DmQ5EClBjI6K
         gyahsFVlSdYEBQDeWhLfQazDH9BPrWSgVYhWxYKfVFgdPyZt7/4WnjiEQeZy3eT+inew
         weG2YkNd4cIZspeamOgZA/QAtYF5ro7ntfWLZg0ccB8xM0SyGYmYW35pfyvLYMXe2dfl
         gmymH/m0RffG98nrwmhmc5tjzOVbYxsoSJRRjbZoKwUP6aBUccbqsBzh3LAxE6d0NF8a
         m/jw==
X-Gm-Message-State: AOJu0YzuaOYx39QiUc0nYeHqIY0ybTSw4q+D6mlHEeENheltwz3Xn8pA
	6MVOFs/c4iWfXThI/Uc37MP/1vDt7OL+EXWGTj5i2SgKYL5wqpNNRfgBEQ==
X-Google-Smtp-Source: AGHT+IEdaM9eOj/+odbXv4o26GzDCh7XQ5LU0aMWRPPvqRo3luvhZxM+MUc/QH08gxrQGSpaXSnq6g==
X-Received: by 2002:a05:6870:d8d0:b0:239:52f9:7f15 with SMTP id of16-20020a056870d8d000b0023952f97f15mr4111212oac.26.1714596463828;
        Wed, 01 May 2024 13:47:43 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:22b9:2301:860f:eff6])
        by smtp.gmail.com with ESMTPSA id rx17-20020a056871201100b002390714e903sm5744408oab.3.2024.05.01.13.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:47:43 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v3 5/7] selftests/bpf: Test kptr arrays and kptrs in nested struct fields.
Date: Wed,  1 May 2024 13:47:27 -0700
Message-Id: <20240501204729.484085-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501204729.484085-1-thinker.li@gmail.com>
References: <20240501204729.484085-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure that BPF programs can declare global kptr arrays and kptr fields
in struct types that is the type of a global variable or the type of a
nested descendant field in a global variable.

An array with only one element is special case, that it treats the element
like a non-array kptr field. Nested arrays are also tested to ensure they
are handled properly.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/prog_tests/cpumask.c        |   5 +
 .../selftests/bpf/progs/cpumask_success.c     | 133 ++++++++++++++++++
 2 files changed, 138 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
index ecf89df78109..2570bd4b0cb2 100644
--- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
+++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
@@ -18,6 +18,11 @@ static const char * const cpumask_success_testcases[] = {
 	"test_insert_leave",
 	"test_insert_remove_release",
 	"test_global_mask_rcu",
+	"test_global_mask_array_one_rcu",
+	"test_global_mask_array_rcu",
+	"test_global_mask_array_l2_rcu",
+	"test_global_mask_nested_rcu",
+	"test_global_mask_nested_deep_rcu",
 	"test_cpumask_weight",
 };
 
diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index 7a1e64c6c065..0b6383fa9958 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -12,6 +12,25 @@ char _license[] SEC("license") = "GPL";
 
 int pid, nr_cpus;
 
+struct kptr_nested {
+	struct bpf_cpumask __kptr * mask;
+};
+
+struct kptr_nested_mid {
+	int dummy;
+	struct kptr_nested m;
+};
+
+struct kptr_nested_deep {
+	struct kptr_nested_mid ptrs[2];
+};
+
+private(MASK) static struct bpf_cpumask __kptr * global_mask_array[2];
+private(MASK) static struct bpf_cpumask __kptr * global_mask_array_l2[2][1];
+private(MASK) static struct bpf_cpumask __kptr * global_mask_array_one[1];
+private(MASK) static struct kptr_nested global_mask_nested[2];
+private(MASK) static struct kptr_nested_deep global_mask_nested_deep;
+
 static bool is_test_task(void)
 {
 	int cur_pid = bpf_get_current_pid_tgid() >> 32;
@@ -460,6 +479,120 @@ int BPF_PROG(test_global_mask_rcu, struct task_struct *task, u64 clone_flags)
 	return 0;
 }
 
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_global_mask_array_one_rcu, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *local, *prev;
+
+	if (!is_test_task())
+		return 0;
+
+	/* Kptr arrays with one element are special cased, being treated
+	 * just like a single pointer.
+	 */
+
+	local = create_cpumask();
+	if (!local)
+		return 0;
+
+	prev = bpf_kptr_xchg(&global_mask_array_one[0], local);
+	if (prev) {
+		bpf_cpumask_release(prev);
+		err = 3;
+		return 0;
+	}
+
+	bpf_rcu_read_lock();
+	local = global_mask_array_one[0];
+	if (!local) {
+		err = 4;
+		bpf_rcu_read_unlock();
+		return 0;
+	}
+
+	bpf_rcu_read_unlock();
+
+	return 0;
+}
+
+static int _global_mask_array_rcu(struct bpf_cpumask **mask0,
+				  struct bpf_cpumask **mask1)
+{
+	struct bpf_cpumask *local;
+
+	if (!is_test_task())
+		return 0;
+
+	/* Check if two kptrs in the array work and independently */
+
+	local = create_cpumask();
+	if (!local)
+		return 0;
+
+	bpf_rcu_read_lock();
+
+	local = bpf_kptr_xchg(mask0, local);
+	if (local) {
+		err = 1;
+		goto err_exit;
+	}
+
+	/* [<mask 0>, NULL] */
+	if (!*mask0 || *mask1) {
+		err = 2;
+		goto err_exit;
+	}
+
+	local = create_cpumask();
+	if (!local) {
+		err = 9;
+		goto err_exit;
+	}
+
+	local = bpf_kptr_xchg(mask1, local);
+	if (local) {
+		err = 10;
+		goto err_exit;
+	}
+
+	/* [<mask 0>, <mask 1>] */
+	if (!*mask0 || !*mask1 || *mask0 == *mask1) {
+		err = 11;
+		goto err_exit;
+	}
+
+err_exit:
+	if (local)
+		bpf_cpumask_release(local);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_global_mask_array_rcu, struct task_struct *task, u64 clone_flags)
+{
+	return _global_mask_array_rcu(&global_mask_array[0], &global_mask_array[1]);
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_global_mask_array_l2_rcu, struct task_struct *task, u64 clone_flags)
+{
+	return _global_mask_array_rcu(&global_mask_array_l2[0][0], &global_mask_array_l2[1][0]);
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_global_mask_nested_rcu, struct task_struct *task, u64 clone_flags)
+{
+	return _global_mask_array_rcu(&global_mask_nested[0].mask, &global_mask_nested[1].mask);
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_global_mask_nested_deep_rcu, struct task_struct *task, u64 clone_flags)
+{
+	return _global_mask_array_rcu(&global_mask_nested_deep.ptrs[0].m.mask,
+				      &global_mask_nested_deep.ptrs[1].m.mask);
+}
+
 SEC("tp_btf/task_newtask")
 int BPF_PROG(test_cpumask_weight, struct task_struct *task, u64 clone_flags)
 {
-- 
2.34.1


