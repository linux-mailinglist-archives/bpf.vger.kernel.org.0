Return-Path: <bpf+bounces-29527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EBB8C2A89
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012B21C21B90
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55E04E1A2;
	Fri, 10 May 2024 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mm+X8vDz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09D44F201;
	Fri, 10 May 2024 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369061; cv=none; b=gyhfGpoEnTYGdOZKsASk1CAX0Z9+V/TUXns4F96HsvI91y+PmTmusT4KTwiqLz221US6wYGeM/zzDeRpsZAPn5/EeN2CCjMLwnem42wXvzxFHgTlPRuf8skvGkFyCbIrLFX1CL7vl6N9X4q1/eavzG6Tx6a7rrmqdxFRAv1XWl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369061; c=relaxed/simple;
	bh=kehJkF7hNW6So1in8gSfWI+KqSEe1cpFQyx2tFoR3xY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JvTK5dcbk+KWHD6JIzC5nqCzM8s3uncZ/4z6IxmwHQj91qKP9l5VqzXvh/AcODDHfTsG/ceqn5FqyzconAi7KpbJWerrINsAe7mNT4Ie3sJ4u+2nIet3PI8fTkeDnptVYqr5zjfAlxGK6Gwq18ar4fhlEiWhh1exkMlhbdnLIH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mm+X8vDz; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4df97a50d1aso87233e0c.1;
        Fri, 10 May 2024 12:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369058; x=1715973858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIumfiaWIEWPZRe/xDRsqp1TqW1h17NwK3fwZB2xMTs=;
        b=mm+X8vDzYYY7wvBxyIG2gCtF0Mak4Brx0bUcX6/8cTXjn6INBMD3xLlp7eVyyPoOlj
         SEvU5TCd05+ONs5PY+0JZ+R1ZTy+c0l04RXzDEpkDa29zaX0Mk8+2uFYpDb23CwErkL1
         VTVU3uDOLSlN7rU5M0TuRYAjxd4xKexueEIAUIhXlCWX2W/HC4JoVV8JfImn/kVSC7Mr
         Mga+Xm6aU2c9cDqB/IWAcjgYUqC8Jqe4PFhEGiaoEKnJhbN2AA/0tKFkXZyPYsEryyiy
         LVk2CFySktAd7VVbW0xPDvuhGryasi/HTlLaM8XH4poE09fiq9Upqh2sU4OYrhG8UKBt
         tleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369058; x=1715973858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIumfiaWIEWPZRe/xDRsqp1TqW1h17NwK3fwZB2xMTs=;
        b=Z9tTsTZPw1FLyrd/6a51APQ3SGBu60iLYqS4aQu2WndKZrPHPHgUvCOq+SAchKj9rM
         Fj/uJmkGDuIrir7mxSida+1jBecZPs+XNmQdsu6BebB5LAovy0XNNZG8vE0GiDdZA48S
         1YuuSP95f5mYZidb4J+ZsepwyK8Ms/kYj+yBCGVobrGO/4yi8Pd0bMa5+WNgXn25cYIJ
         EVxqFFnI2BxQWApXFLBHf5pwwn4O0+g/0LAyvEmw8P6p9TRpsU0Y+tmcOE9TlbefbKqd
         +C63XPsMdK16u1r8dLIK4vFfIb1lyM2A+Df2p2iapBCu9Nc7sRF2rolc57VqH7p5y2FL
         A6Dw==
X-Gm-Message-State: AOJu0YwRql+FGTy+OrnoRAfcro/E1iXCyeim1cbRiBFzVTcMt7lYKimM
	FZqgYZBFSCt7jH+lxHsanN6BcFXwuvJZmKaQ2e62PvBD44ZJ93gJyI5+OA==
X-Google-Smtp-Source: AGHT+IExx1AJFWIy0pm2XKH2XcB1MuY8euiT1hHYapSLEQAZ6Cjh9SZrHHIpwCazZphs6mgyVZoBrQ==
X-Received: by 2002:a05:6122:4597:b0:4df:16d8:2b82 with SMTP id 71dfb90a1353d-4df88283ba4mr4236908e0c.1.1715369058463;
        Fri, 10 May 2024 12:24:18 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5b46a26sm23863251cf.80.2024.05.10.12.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:24:18 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v8 08/20] selftests/bpf: Test adding kernel object to bpf graph
Date: Fri, 10 May 2024 19:24:00 +0000
Message-Id: <20240510192412.3297104-9-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240510192412.3297104-1-amery.hung@bytedance.com>
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch tests bpf graphs storing kernel objects.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 14 +++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  5 ++++
 .../selftests/bpf/prog_tests/linked_list.c    |  6 ++--
 .../testing/selftests/bpf/progs/linked_list.c | 15 ++++++++++
 .../testing/selftests/bpf/progs/linked_list.h |  8 +++++
 .../selftests/bpf/progs/linked_list_fail.c    | 29 +++++++++++++++++++
 6 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 097a8d1c2ef8..90dda6335c04 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -494,6 +494,18 @@ __bpf_kfunc static u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused
 	return arg;
 }
 
+__bpf_kfunc static struct bpf_testmod_linked_list_obj *
+bpf_kfunc_call_test_acq_linked_list_obj(void)
+{
+	return kzalloc(sizeof(struct bpf_testmod_linked_list_obj), GFP_ATOMIC);
+}
+
+__bpf_kfunc static void
+bpf_kfunc_call_test_rel_linked_list_obj(struct bpf_testmod_linked_list_obj *obj)
+{
+	kvfree(obj);
+}
+
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
@@ -520,6 +532,8 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_acq_linked_list_obj, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_rel_linked_list_obj, KF_RELEASE)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static int bpf_testmod_ops_init(struct btf *btf)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index 6d24e1307b64..77c36fc016e3 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -99,4 +99,9 @@ struct bpf_testmod_ops2 {
 	int (*test_1)(void);
 };
 
+struct bpf_testmod_linked_list_obj {
+	int val;
+	struct bpf_list_node node;
+};
+
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index 2fb89de63bd2..813c2e9a2346 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -80,8 +80,8 @@ static struct {
 	{ "direct_write_node", "direct access to bpf_list_node is disallowed" },
 	{ "use_after_unlock_push_front", "invalid mem access 'scalar'" },
 	{ "use_after_unlock_push_back", "invalid mem access 'scalar'" },
-	{ "double_push_front", "arg#1 expected pointer to allocated object" },
-	{ "double_push_back", "arg#1 expected pointer to allocated object" },
+	{ "double_push_front", "arg#1 expected pointer to allocated object or trusted pointer" },
+	{ "double_push_back", "arg#1 expected pointer to allocated object or trusted pointer" },
 	{ "no_node_value_type", "bpf_list_node not found at offset=0" },
 	{ "incorrect_value_type",
 	  "operation on bpf_list_head expects arg#1 bpf_list_node at offset=48 in struct foo, "
@@ -96,6 +96,8 @@ static struct {
 	{ "incorrect_head_off2", "bpf_list_head not found at offset=1" },
 	{ "pop_front_off", "off 48 doesn't point to 'struct bpf_spin_lock' that is at 40" },
 	{ "pop_back_off", "off 48 doesn't point to 'struct bpf_spin_lock' that is at 40" },
+	{ "direct_write_node_kernel", "" },
+	{ "push_local_node_to_kptr_list", "operation on bpf_list_head expects arg#1 bpf_list_node at offset=8 in struct bpf_testmod_linked_list_obj, but arg is at offset=8 in struct bpf_testmod_linked_list_obj" },
 };
 
 static void test_linked_list_fail_prog(const char *prog_name, const char *err_msg)
diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/testing/selftests/bpf/progs/linked_list.c
index 26205ca80679..148ec67feaf7 100644
--- a/tools/testing/selftests/bpf/progs/linked_list.c
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -378,4 +378,19 @@ int global_list_in_list(void *ctx)
 	return test_list_in_list(&glock, &ghead);
 }
 
+SEC("tc")
+int push_to_kptr_list(void *ctx)
+{
+	struct bpf_testmod_linked_list_obj *f;
+
+	f = bpf_kfunc_call_test_acq_linked_list_obj();
+	if (!f)
+		return 0;
+
+	bpf_spin_lock(&glock3);
+	bpf_list_push_back(&ghead3, &f->node);
+	bpf_spin_unlock(&glock3);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/linked_list.h b/tools/testing/selftests/bpf/progs/linked_list.h
index c0f3609a7ffa..14bd92cfdb6f 100644
--- a/tools/testing/selftests/bpf/progs/linked_list.h
+++ b/tools/testing/selftests/bpf/progs/linked_list.h
@@ -5,6 +5,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_experimental.h"
+#include "../bpf_testmod/bpf_testmod.h"
 
 struct bar {
 	struct bpf_list_node node;
@@ -52,5 +53,12 @@ struct {
 private(A) struct bpf_spin_lock glock;
 private(A) struct bpf_list_head ghead __contains(foo, node2);
 private(B) struct bpf_spin_lock glock2;
+private(C) struct bpf_spin_lock glock3;
+private(C) struct bpf_list_head ghead3 __contains_kptr(bpf_testmod_linked_list_obj, node);
+
+struct bpf_testmod_linked_list_obj *bpf_kfunc_call_test_acq_linked_list_obj(void) __ksym;
+void bpf_kfunc_call_test_rel_linked_list_obj(struct bpf_testmod_linked_list_obj *obj) __ksym;
+struct bpf_testmod_rb_tree_obj *bpf_kfunc_call_test_acq_rb_tree_obj(void) __ksym;
+void bpf_kfunc_call_test_rel_rb_tree_obj(struct bpf_testmod_rb_tree_obj *obj) __ksym;
 
 #endif
diff --git a/tools/testing/selftests/bpf/progs/linked_list_fail.c b/tools/testing/selftests/bpf/progs/linked_list_fail.c
index 6438982b928b..5f8063ecc448 100644
--- a/tools/testing/selftests/bpf/progs/linked_list_fail.c
+++ b/tools/testing/selftests/bpf/progs/linked_list_fail.c
@@ -609,4 +609,33 @@ int pop_back_off(void *ctx)
 	return pop_ptr_off((void *)bpf_list_pop_back);
 }
 
+SEC("?tc")
+int direct_write_node_kernel(void *ctx)
+{
+	struct bpf_testmod_linked_list_obj *f;
+
+	f = bpf_kfunc_call_test_acq_linked_list_obj();
+	if (!f)
+		return 0;
+
+	*(__u64 *)&f->node = 0;
+	bpf_kfunc_call_test_rel_linked_list_obj(f);
+	return 0;
+}
+
+SEC("?tc")
+int push_local_node_to_kptr_list(void *ctx)
+{
+	struct bpf_testmod_linked_list_obj *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+
+	bpf_spin_lock(&glock3);
+	bpf_list_push_back(&ghead3, &f->node);
+	bpf_spin_unlock(&glock3);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.20.1


