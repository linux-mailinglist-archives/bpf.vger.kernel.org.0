Return-Path: <bpf+bounces-29427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 600188C1BEF
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 03:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9851F226DC
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 01:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AE913AA56;
	Fri, 10 May 2024 01:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3yPjMjl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB6C13AA32
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 01:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715303604; cv=none; b=byd9xc85jn7cA7IrA+Fwg7wYXeSnvH98KnM0d9qJj274RnlemVHJ6UWQYYg5u1N5Nu5Ee9EsSIADApL5lvdQ9HJPKiJOB89utz7ecHunnDmUB/6l8YAvHeBip/DI4qknGpXBu79cYucgP9sa/BCWkmhw0Pf2L63K9Isdtey1R5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715303604; c=relaxed/simple;
	bh=Ma3Vu2MlOrX3+7gHJ0smej7Cz6EfF40UjlbMuQF7iyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h2qEVkeAZlAK/tCFiE+bmhZvZsdnxi0Ip7qHJZ3s+E+NVNE/tAWwmWSpAjwjrzM13PsasGVpwTDRdK3oEYiKdTof2+uiy9K+kqKlf8QKYJtfj3P+QxjsgywtA4Kb53tloSioA3UoE39bDSYpMwNdttOwLNEjYJ3SHok5XHuERWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3yPjMjl; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-23e78ef3de7so813510fac.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 18:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715303602; x=1715908402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEkoRMBGu2GwDIk9DvRSHZhuDVYyTKX9czbFcw2JQz8=;
        b=W3yPjMjl0GSSR6S/TTMhIuPu8njddsfoX5mGzHo750Yp4V43BjAEa2++bno+W2dEHh
         PtIyv3XHv85IuaO+MMktJ92eXZuW5BTNzmr4FCFqgDwzxCFZCzrb0hZzgPAf82Wnpv4N
         RYn+ya12zFAAi3Afyvvu/wOzzhmBua9YTO6PlgR0gIs22pTcycyqWsTwhuuPLvtMmoWR
         wbFtSlHK1Hxt5wvvRpwNOmUIKrtubna431vu/83PnmbGLV+u5qnc+EgWm29jZbTjDUKw
         PNQUfu/grD2WnAlTxRu2MQHrgZqj5+/8TyXcMV8oyNWze58U7vPEEMV1VT1xmYHCId/u
         9J9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715303602; x=1715908402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEkoRMBGu2GwDIk9DvRSHZhuDVYyTKX9czbFcw2JQz8=;
        b=P3XvXZMC27eEQyqN+vD0RRi2X9LsFFt/7EO0zmfHRfUYQDaaIHg8cbQOT95NzB2NlF
         SwdR5aXD53c4JKn2esI3y2jWp/YBdhH7RFKLACO9D6iXzgCbtNnCRFfai3uKesUMRsay
         isIrrBFsxTt0gjeNKTFYZ0GtNAcYvpGQpgv0W/CbyQkant1ubbRARsr47M3fqSpmKrPq
         BgWnC3Uzsk3IB8+feDupxDnR5+SFEJjGzyu/ApZIJhxz/z6Yh70e3TzlbUT3SwHzmLyQ
         36vgQp/0YLoikoQAB2dfWVzABfcV+zOE1wu/XQb7I1pDVI/qfavID4esoS3P7o6okO+V
         81Vw==
X-Gm-Message-State: AOJu0YwncGZGYe6MjWrZusr6pz2g/l8vxIlJ2GcQXxucLoQaDIDskzk5
	68xCnk7NnQFLAj0VFdRi+gIuRLnQLearga0QuO8O6/uN0nFFUpf/5sYf9Q==
X-Google-Smtp-Source: AGHT+IF0oGU2w+HRZ6H4ovlZ08e/X89Sw6xvJQPVGKpnO8XeqrtDFrdXgcolyeMNlUqRSAi5W1p/sA==
X-Received: by 2002:a05:6871:54a:b0:21f:d2a2:7ff4 with SMTP id 586e51a60fabf-24172a9c787mr1815371fac.17.1715303602107;
        Thu, 09 May 2024 18:13:22 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:66fe:82c7:2d03:7176])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0e01a8b23sm476874a34.6.2024.05.09.18.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 18:13:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 7/9] selftests/bpf: Test kptr arrays and kptrs in nested struct fields.
Date: Thu,  9 May 2024 18:13:10 -0700
Message-Id: <20240510011312.1488046-8-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510011312.1488046-1-thinker.li@gmail.com>
References: <20240510011312.1488046-1-thinker.li@gmail.com>
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


