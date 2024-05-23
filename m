Return-Path: <bpf+bounces-30418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95198CD94D
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 19:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E582B2258E
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 17:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD5F7E116;
	Thu, 23 May 2024 17:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2Ln+t11"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B54763F2
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486140; cv=none; b=qvakpS9532JzM1YJtDNkBqGeXw9T0D8ZNhaHSMHyvfM+TTyDSjN3FvIkt5FI/IJjqbMMsBMlxwlxuehH69MnnSKNJ4Jb0pUe06D2BwRDVt/TTTTfSYUWm0aAwisVSmW9S3jqjRdiiBTrJ/CPVobUcN0XAIEOxJ93+DJSvEW7fs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486140; c=relaxed/simple;
	bh=6ddzF50xdfvUTLbRPmh03d817gxeSkpTT82lJoW/bdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C+Ufo6p+Ex/AILyWNN6ylBhcfLh7pjl81t38NTvpxlu3s4mScjIO1nmhrcGDUIumBpzwIxh3i69iXlxlTTL233N5kA517nuovuKYAnQw+KcisdrwCH5+LE1i0tVq6FP+deGcsmAiiaddIBWFwiZm8f5g/dkGZzLS7Fuo+ufH/Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2Ln+t11; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6114c9b4d83so57967707b3.3
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 10:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486137; x=1717090937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54DvYQpAAB02Xh88RZICeBNDEtLg9JnAjUy2/MHSl1w=;
        b=l2Ln+t11/LzlK/VRGklKAib8BYhcj+tZdGyYr8FOapHBFnZeSZKxxGfBcKtarUX5L2
         JOVM4mPwMupkxZfB8FXqEqPgDxSemVHtR/qZe2RfdqzW9dfjRj/PADGV6Smt0+UNQs4V
         wQlhcFErOA1GCje+pJZsDdKVMmmPsa70QPES6mhyn/OsXDyoqgsWyEUAhDQqi72kmx2a
         PZmVoxUNZDt7irzw730fu8W8R7ctxWKpl4VZ09jsPnXBrQabY18VUyynAwG8MNIXJKAx
         53Qy881aPg09rmT4gwYxLM4ohrIPriKC7UlzwVqQfVzO79Ikyp9vQX6Kt7xcVnGgbDE4
         E33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486137; x=1717090937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54DvYQpAAB02Xh88RZICeBNDEtLg9JnAjUy2/MHSl1w=;
        b=wN1Oqryy2shAFiz/rpo8MOX9e+U2u3mov4OOVGocQrcHTMQ2qfL4d3bS42lvkDXJcG
         QMj6+HP8m8MqsnNEPF/GTpC6Z/3IEqkevSXtNQ8tA1c3NaGaMn1LaogIq6NGWdBKVHdy
         Am+TmD8eYs1othDi635h5JBx8gzW8SKjLAzzOKx1b+Cu2n4TshnRA20FCFNYjsNujRHS
         1nxHAdHYIor7mu67j2VDrsRgjKXEc5sagGSE+LSPouzEplCbdfKoqLdC+YfOuG9dOsFW
         olqV8GMuv7KAY7P2okyg0XuxANJR7o/SznIcxYwoyD6/hf10YVM8ZeQacQD1mXdPVCfP
         oRJg==
X-Gm-Message-State: AOJu0YzGtRKt2XbCUeP8t3I1iRAymKfMv3q7T29Q2tECI4FX48LW/T+W
	ci2s9rpMlwaJ9PN09e9mPhqzvWjgB/PpiDCCf9cmH12aTwvq3P6+H1oIWA==
X-Google-Smtp-Source: AGHT+IHr9UIkxAVA+O7zsOGJSdI/4CFIOyqP6AmaYw1m3gbrkfMGeEKGj6rsgUlDGiZzkqqKrAR2dA==
X-Received: by 2002:a0d:d415:0:b0:627:972f:bac3 with SMTP id 00721157ae682-627e4688f57mr62096587b3.8.1716486137051;
        Thu, 23 May 2024 10:42:17 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a2b5:fcfb:857c:2908])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e2514bbsm63652277b3.42.2024.05.23.10.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:42:16 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v7 7/9] selftests/bpf: Test kptr arrays and kptrs in nested struct fields.
Date: Thu, 23 May 2024 10:42:00 -0700
Message-Id: <20240523174202.461236-8-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523174202.461236-1-thinker.li@gmail.com>
References: <20240523174202.461236-1-thinker.li@gmail.com>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/prog_tests/cpumask.c        |   5 +
 .../selftests/bpf/progs/cpumask_success.c     | 171 ++++++++++++++++++
 2 files changed, 176 insertions(+)

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
index 7a1e64c6c065..fd8106831c32 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -12,6 +12,31 @@ char _license[] SEC("license") = "GPL";
 
 int pid, nr_cpus;
 
+struct kptr_nested {
+	struct bpf_cpumask __kptr * mask;
+};
+
+struct kptr_nested_pair {
+	struct bpf_cpumask __kptr * mask_1;
+	struct bpf_cpumask __kptr * mask_2;
+};
+
+struct kptr_nested_mid {
+	int dummy;
+	struct kptr_nested m;
+};
+
+struct kptr_nested_deep {
+	struct kptr_nested_mid ptrs[2];
+	struct kptr_nested_pair ptr_pairs[3];
+};
+
+private(MASK) static struct bpf_cpumask __kptr * global_mask_array[2];
+private(MASK) static struct bpf_cpumask __kptr * global_mask_array_l2[2][1];
+private(MASK) static struct bpf_cpumask __kptr * global_mask_array_one[1];
+private(MASK) static struct kptr_nested global_mask_nested[2];
+private(MASK_DEEP) static struct kptr_nested_deep global_mask_nested_deep;
+
 static bool is_test_task(void)
 {
 	int cur_pid = bpf_get_current_pid_tgid() >> 32;
@@ -460,6 +485,152 @@ int BPF_PROG(test_global_mask_rcu, struct task_struct *task, u64 clone_flags)
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
+/* Ensure that the field->offset has been correctly advanced from one
+ * nested struct or array sub-tree to another. In the case of
+ * kptr_nested_deep, it comprises two sub-trees: ktpr_1 and kptr_2.  By
+ * calling bpf_kptr_xchg() on every single kptr in both nested sub-trees,
+ * the verifier should reject the program if the field->offset of any kptr
+ * is incorrect.
+ *
+ * For instance, if we have 10 kptrs in a nested struct and a program that
+ * accesses each kptr individually with bpf_kptr_xchg(), the compiler
+ * should emit instructions to access 10 different offsets if it works
+ * correctly. If the field->offset values of any pair of them are
+ * incorrectly the same, the number of unique offsets in btf_record for
+ * this nested struct should be less than 10. The verifier should fail to
+ * discover some of the offsets emitted by the compiler.
+ *
+ * Even if the field->offset values of kptrs are not duplicated, the
+ * verifier should fail to find a btf_field for the instruction accessing a
+ * kptr if the corresponding field->offset is pointing to a random
+ * incorrect offset.
+ */
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_global_mask_nested_deep_rcu, struct task_struct *task, u64 clone_flags)
+{
+	int r, i;
+
+	r = _global_mask_array_rcu(&global_mask_nested_deep.ptrs[0].m.mask,
+				   &global_mask_nested_deep.ptrs[1].m.mask);
+	if (r)
+		return r;
+
+	for (i = 0; i < 3; i++) {
+		r = _global_mask_array_rcu(&global_mask_nested_deep.ptr_pairs[i].mask_1,
+					   &global_mask_nested_deep.ptr_pairs[i].mask_2);
+		if (r)
+			return r;
+	}
+	return 0;
+}
+
 SEC("tp_btf/task_newtask")
 int BPF_PROG(test_cpumask_weight, struct task_struct *task, u64 clone_flags)
 {
-- 
2.34.1


