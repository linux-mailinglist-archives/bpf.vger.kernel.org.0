Return-Path: <bpf+bounces-62204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E8DAF6588
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 00:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799521C45FDF
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 22:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C121A2D9EE1;
	Wed,  2 Jul 2025 22:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WI/+aWCr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78D528A3ED
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751496143; cv=none; b=nQb2zZIh+gE4qaglgipl9rYFl9FmTB3O3A54CG1SGd3yxxreEUn3BuFundjTqRj7SXjorMybNiuELafxSD7asY3CQyc4kiSwbl39lp1dbDVHM2F5gK6I5wqUjs2YUeX8vuXeXGsUeDCqq8fhuA4X5c2vGIqVfH5iXCeoHhHaTHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751496143; c=relaxed/simple;
	bh=bsbkp/45zYy0jY/QyEB6FJcsDLDSomQK/mqt26Ym2vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtDsIwD+2Z66irzX1pHJdWaKpSOL4eEQqdgruTMTzu3yr2bNCc6apcDxTEFG1/Kl34gqBonZmw11g3PORPT2I1OYGb00eaZm2N/hetyE5uxRT2at7WSnq14Uf5jS+IkNYJAOCfaQ5/TimD+WLnay/44izZ5PXbdurN2FO/O42Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WI/+aWCr; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7111d02c777so47820657b3.3
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 15:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751496141; x=1752100941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ln/0hKkCf5kgOGZrRXXVB80vk89es0ox+HhKi6k5Es=;
        b=WI/+aWCrw3rC1u7hzSOY5v/D5DrY3VBYvZRrl4CZt3cTDxBcu99Q/doJR0o4k4srYz
         qTiUdnguNqtg/Ju8XlAqELKPeu6yWr0HazTd+dEDP4CYnuaJb3L74QKgzccCQeqsTs0s
         jrnvUS2alILes8IzoLi6MkKpyoBx7f1UW9U9zPNP402NsLXGp6Q+Yq7zm9IDO+/q2sA4
         Eovy10NR38kYifHw9IlCV8/hz1Ay371EuaTc61hKWVYKVwQ/G41JHfuhwJN/7lwE/N4j
         9O/bY3yh+7ZzodYGvj+dm3F9b4I1ZbLBmWE7L96JRxrcY0KoLt/KfcNI2WdU2oMFHT6Q
         B4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751496141; x=1752100941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Ln/0hKkCf5kgOGZrRXXVB80vk89es0ox+HhKi6k5Es=;
        b=h4Xknuf30xv28qbOOY17yR9nXoUGsBRUvB6WIQ9gGZq8+ht1jjZmwvoIrEvbgLOrka
         ak6LPHIeqqfRNy0oIJfhmfQxJQMHca0L091K+FBFgerSfrB6s7hx5t1zyuOjNztbodq8
         ZfF513iD6eh/aouoO0NzRLLuXJae+ClzdEYq0qmgVa/VqJfWBKxmAOPHwtDXg0BelOhw
         7rWUe3NDGP294l2HRNnC06H/3DemppmIzuKtOAHY31IJIOvEvaH1jh6xMJHIU1BiitN6
         u66FTH/l8WYbxsiUUE9PSNPxcI+c+Y/x/H3+YBLPfOPMd5lA2qR70IoWMU7AXNJNhBsw
         Ew2A==
X-Gm-Message-State: AOJu0YySG0rVV3blIsVazsR4lmd8/xKh4q4fNMOep6S/lBye49965mYp
	dCyAEnAntLzVks15d8ZtxrniXsPk5le1mjIl7N8MAcfwn1Ii5TooN18iCFAV87ml
X-Gm-Gg: ASbGnctDpPv0AyEWzxH2ovfPyrSJAz6vDKp7xeqW7zzdF4uTBaHeur4vM+9uL6u1Xzj
	Jo8gitjXAhtgfWuKqC0LtHFtSwxnv3zxXAdCwdQj6WV/mFbqeDNz617dDfgxmKnd+JLx3CXH9Kt
	k8xVw1x1GUf26FCrE/z1P7LEvtkThZaesCl1JvdrgSQfCI59GArgzOXwuPF8I2SXK7Wp4mivMR9
	woh5TY8KjfnM+0tyVulJfladwU/F9NzIv6QkJJKRtXKlNyrDUmm592VFe/g4zcQxYtHUfEquCq2
	M3Z7nC3UJboraF/wB0AoXseVARiaiSLACKKba0tsvPDrrDBwnJVlvg==
X-Google-Smtp-Source: AGHT+IFyghlkMyyQib3vgJzBlfIieh1+vde+R3hyzqjqSQFdaVSRfgJf1hgPeROXbtXUynnbraPPDA==
X-Received: by 2002:a05:690c:3583:b0:714:271:3103 with SMTP id 00721157ae682-7164d4c304bmr64249257b3.38.1751496140746;
        Wed, 02 Jul 2025 15:42:20 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:56::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7165810ff93sm2093987b3.39.2025.07.02.15.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 15:42:20 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 6/8] selftests/bpf: test cases for __arg_untrusted
Date: Wed,  2 Jul 2025 15:42:07 -0700
Message-ID: <20250702224209.3300396-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702224209.3300396-1-eddyz87@gmail.com>
References: <20250702224209.3300396-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check usage of __arg_untrusted parameters with PTR_TO_BTF_ID:
- combining __arg_untrusted with other tags is forbidden;
- passing of {trusted, untrusted, map value, scalar value, values with
  variable offset} to untrusted is ok;
- passing of PTR_TO_BTF_ID with a different type to untrusted is ok;
- passing of untrusted to trusted is forbidden.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_global_ptr_args.c      | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index 4ab0ef18d7eb..772e8dd3e001 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -179,4 +179,70 @@ int BPF_PROG(trusted_acq_rel, struct task_struct *task, u64 clone_flags)
 	return subprog_trusted_acq_rel(task);
 }
 
+__weak int subprog_untrusted_bad_tags(struct task_struct *task __arg_untrusted __arg_nullable)
+{
+	return task->pid;
+}
+
+SEC("tp_btf/sys_enter")
+__failure
+__msg("arg#0 untrusted cannot be combined with any other tags")
+int untrusted_bad_tags(void *ctx)
+{
+	return subprog_untrusted_bad_tags(0);
+}
+
+__weak int subprog_untrusted(struct task_struct *task __arg_untrusted)
+{
+	return task->pid;
+}
+
+SEC("tp_btf/sys_enter")
+__success
+__log_level(2)
+__msg("r1 = {{.*}}; {{.*}}R1_w=trusted_ptr_task_struct()")
+__msg("Func#1 ('subprog_untrusted') is global and assumed valid.")
+__msg("Validating subprog_untrusted() func#1...")
+__msg(": R1=untrusted_ptr_task_struct")
+int trusted_to_untrusted(void *ctx)
+{
+	return subprog_untrusted(bpf_get_current_task_btf());
+}
+
+char mem[16];
+u32 off;
+
+SEC("tp_btf/sys_enter")
+__success
+int anything_to_untrusted(void *ctx)
+{
+	/* untrusted to untrusted */
+	subprog_untrusted(bpf_core_cast(0, struct task_struct));
+	/* wrong type to untrusted */
+	subprog_untrusted((void *)bpf_core_cast(0, struct bpf_verifier_env));
+	/* map value to untrusted */
+	subprog_untrusted((void *)mem);
+	/* scalar to untrusted */
+	subprog_untrusted(0);
+	/* variable offset to untrusted (map) */
+	subprog_untrusted((void *)mem + off);
+	/* variable offset to untrusted (trusted) */
+	subprog_untrusted((void *)bpf_get_current_task_btf() + off);
+	return 0;
+}
+
+__weak int subprog_untrusted2(struct task_struct *task __arg_untrusted)
+{
+	return subprog_trusted_task_nullable(task);
+}
+
+SEC("tp_btf/sys_enter")
+__failure
+__msg("R1 type=untrusted_ptr_ expected=ptr_, trusted_ptr_, rcu_ptr_")
+__msg("Caller passes invalid args into func#{{.*}} ('subprog_trusted_task_nullable')")
+int untrusted_to_trusted(void *ctx)
+{
+	return subprog_untrusted2(bpf_get_current_task_btf());
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.1


