Return-Path: <bpf+bounces-29025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8788BF64B
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 08:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5FD1F238E0
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 06:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B222260B;
	Wed,  8 May 2024 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWzrCIqZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCAF2263E
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149954; cv=none; b=AKpnT/iJ2RdQolu0/79GbS8TAHWAPRqib5BnS8Y/1ypXx2THo9VjNo9SQRwUP6URR+2tZ+nDIHMqvOSd8FDhqyCC/sg/86duZtr7TPq0BSco/8Qga6yMkrnik3KjywIWM36FXD01lQBjDjp0aXvVZZ+XJSDyPxJ0Jbks9IjV4Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149954; c=relaxed/simple;
	bh=Ma3Vu2MlOrX3+7gHJ0smej7Cz6EfF40UjlbMuQF7iyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YPQ8iHOru9zHpO8hhnVXZwhcFb39O6D0nVxn7JLQfQY3BmH+1ECqsFcFpS6XHK2/8ZsoBmTp0Z4BTEwapRNC2ih2suuJXKryDGtzmdypxtTuhneDxKsTGbSVxk8PS7VkhrP0uU2C5Kffyh3F8psuaYpD3DwjXYOfrnDK/4boJAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWzrCIqZ; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c96a556006so1776572b6e.0
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 23:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715149951; x=1715754751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEkoRMBGu2GwDIk9DvRSHZhuDVYyTKX9czbFcw2JQz8=;
        b=fWzrCIqZif9U8wamrp2xPXEu/rrZV+rtlvg5e0DfHLtzmqSOqLahADmFtdqarcJa8N
         nWiBiEfH1eoyiJzFJCmVlCXRFcc54sbxkRGpd1/I0nx5C/i26ml7SvE15r6tsoqqQvNX
         GA+qHB7XOkxjOcMw6QWlAQCuBg5ykkU1M+sW5P4yM/CVxndlNU9PjU9OlP/arefiS4ki
         ZZnxHyY4Rv7bDIx66Sjo5S7BKwIdV4wxTTMCpeblaFOxok01Nx7r9kct4AS9/CyDUGXh
         dizU1zLJi2uRpxjxvbwuUWWXatC6MxDXwX3lL0ehU7b79GUpVw1EicU5gKQY8jCJ3a0w
         vgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715149951; x=1715754751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEkoRMBGu2GwDIk9DvRSHZhuDVYyTKX9czbFcw2JQz8=;
        b=BNiJveDQ553R0PSdhJVgeM1XPkQ58lVfRv1ULdPqy9ogkajlsyHUMXmWs8oDTCSXM9
         AmvHtb99rnjYaJ8tELVzUboR+wRJMCml4z1WsuD+pBq5UBF93Y2f5lFTOFUfhpsB7jH8
         gmQ1M99l8gYL8BSCu2fPXSNNUQbqRtF0iVicjR59vPnsj0WljE9zJl4cfuHyFaBy9fZx
         65s/SrKfdZWz4VPznIm4l/GMhu0NTdGAjrcC68pGITiU99K9MjOmGRvJoIh9KftWqh53
         +fAQDimE9vvzRoFxdLie+bTxYf5RYIaL/Ph578K5CXEjFQEDz5A394cG1tcmIiuP/f7A
         dPQw==
X-Gm-Message-State: AOJu0Yw34UdiIrjMc0FFQqGB0Ft6eCfcbht2NlJUAKJsC5Fu+USOo3UP
	aLnz3jxFEGRy9J/PXeociTW8V6DfnedTDB+Ybaw+jKcUwys2FlTI9EHQVw==
X-Google-Smtp-Source: AGHT+IGEJ82LSRWlA/x8CLxWXmIVpaFO1IO1TsScpC04a+CNSDKnlQeSc5rsxFXwUwyaoISZuySy2Q==
X-Received: by 2002:aca:1e17:0:b0:3c8:575f:4135 with SMTP id 5614622812f47-3c9852977a1mr1868417b6e.7.1715149951681;
        Tue, 07 May 2024 23:32:31 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:28e:823a:cbf2:fea6])
        by smtp.gmail.com with ESMTPSA id z22-20020a056808029600b003c9729ac86dsm841371oic.11.2024.05.07.23.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 23:32:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 7/9] selftests/bpf: Test kptr arrays and kptrs in nested struct fields.
Date: Tue,  7 May 2024 23:32:16 -0700
Message-Id: <20240508063218.2806447-8-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508063218.2806447-1-thinker.li@gmail.com>
References: <20240508063218.2806447-1-thinker.li@gmail.com>
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


