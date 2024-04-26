Return-Path: <bpf+bounces-27967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A788B3FC8
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 20:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EF11C2172B
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 18:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283BBBA46;
	Fri, 26 Apr 2024 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSTfQXjG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457064A23
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714157796; cv=none; b=JUyDiX5IyDFntfEdFdZtKMRDTqTKlKiydFrueRYwg+tsx8VlN+RxPrcQW5pUc542LjqcHnKNk4fxp2KtnJFiqNVmtkueu67wKCqGIOmFSBXIT/xAFFjGxaV5tYaA38Au+LLs2Wob27lXzyexRxpvHH6wLd5en5udLdPxzn4rcLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714157796; c=relaxed/simple;
	bh=REvM3HUskqkxrmJWJ0pWPnDLhLvm3srWy794L/diMW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qC0SPp4MiWhA6lmgvXdqRkto+ZP220dNpQumg0ihpe3khRjOCjt/B4MGfh+dPJmMdUwYwjPTdPw39xTqJ3l+BXOZGvMR5pC+i8OuJ/NROepcJ1x3oRnuQ9JpS9aUAvtEEjYJrEkHL6FrmQfXL49hBbbosgiBjrh+I5+Eq2b50NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSTfQXjG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f0b9f943cbso2252402b3a.0
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 11:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714157794; x=1714762594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A79BIkOX+eXQkEUt/jq1pUeLcpjsSHILGeBo6dbZBdY=;
        b=nSTfQXjGtMRnb60Uk9XaiURvDCNSh8PFX7TIFFZ2iELEa4o8aPFlZEZW0SHslr3kwM
         yur7GrEp6uDeHVjPFh9bP8ydG3BDUSWuMUf30a2KS2/Y9hLHMljCtqioi/YwFGxVHf6R
         i69oiIoOaUBqX97wQDTzVvvRay8O/j3SWBILbM8+r8j7CiPvz9KQUO+zH0cOh5O8blPY
         h2+TxAdG0Mjx97GymHBAaHH2fJoV4fqpiPezN8QIkFGcRmzUIkJITBu/cMPLYQYIufC5
         652L4e4eqRMj9a4dvhKirJ2/aL2zDzCvJ8MBpaWcjm3EPWEz7ymfxLQFR+euipx63qvI
         HXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714157794; x=1714762594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A79BIkOX+eXQkEUt/jq1pUeLcpjsSHILGeBo6dbZBdY=;
        b=TYzSKmonSX2UjL+l++PO+yyggWQP7fe4FJ0nRntyJd16xXpGopA58iLDdZ4/GEfRH9
         Cw0XjtXJR8nVQWB561at7FylwintnU057jI7+OCrT595RwoYklNyTmEQ0A64erASyQ/5
         uG3adawnTfWtl7ZxMqwtKclxWOp61TQHqe1ontcr/9P/ydfFuTKD+mwsEqaiNBEOmOx2
         KEVJKmPpZ9+gkGspElKQ4HeRxqPVJ65lJrQoWWvCPS0iAHJ7NRx+fHzXmncGsx6mRAHE
         DxcoXbP+EVC06lP5zsjeaxbkkqwhmry/FI1IfW8l3j7OaanVSVsKeFGZIsDrMkeZ5Sp/
         fJcg==
X-Gm-Message-State: AOJu0Yx6IoBQHE4RlrZTUAc1QBAAP8mhemtghJKhKpK1WeEZtRmItEVa
	/5nzn7S+DU6S/EQipMiz1vBtTuiwXCbx7Q1GorBrRpt642SEsLlY3V6rWg==
X-Google-Smtp-Source: AGHT+IHogUEIRx+7apwlNOsdXJwUwsW3pFH6NI8ELQMzx3zWiWUQN6tg1t9eztC0DMU+IRR7TaST2g==
X-Received: by 2002:a05:6a20:551d:b0:1aa:5ca9:c565 with SMTP id ko29-20020a056a20551d00b001aa5ca9c565mr3823179pzb.8.1714157793706;
        Fri, 26 Apr 2024 11:56:33 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:ea32])
        by smtp.gmail.com with ESMTPSA id o8-20020a635a08000000b005f3d2592b5csm14913547pgb.47.2024.04.26.11.56.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Apr 2024 11:56:33 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	liamwisehart@meta.com,
	kernel-team@fb.com
Subject: [PATCH bpf-next] bpf: Fix verifier assumptions about socket->sk
Date: Fri, 26 Apr 2024 11:56:30 -0700
Message-Id: <20240426185630.17938-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The verifier assumes that 'sk' field in 'struct socket' is valid
and non-NULL when 'socket' pointer itself is trusted and non-NULL.
That may not be the case when socket was just created and
passed to LSM socket_accept hook.
Fix this verifier assumption and adjust tests.

Reported-by: Liam Wisehart <liamwisehart@meta.com>
Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                         | 23 +++++++++++++++----
 .../selftests/bpf/progs/local_storage.c       | 20 ++++++++--------
 .../testing/selftests/bpf/progs/lsm_cgroup.c  |  8 +++++--
 3 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4e474ef44e9c..c2780a5c396a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2368,6 +2368,8 @@ static void mark_btf_ld_reg(struct bpf_verifier_env *env,
 	regs[regno].type = PTR_TO_BTF_ID | flag;
 	regs[regno].btf = btf;
 	regs[regno].btf_id = btf_id;
+	if (type_may_be_null(flag))
+		regs[regno].id = ++env->id_gen;
 }
 
 #define DEF_NOT_SUBREG	(0)
@@ -5400,8 +5402,6 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 		 */
 		mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, kptr_field->kptr.btf,
 				kptr_field->kptr.btf_id, btf_ld_kptr_type(env, kptr_field));
-		/* For mark_ptr_or_null_reg */
-		val_reg->id = ++env->id_gen;
 	} else if (class == BPF_STX) {
 		val_reg = reg_state(env, value_regno);
 		if (!register_is_null(val_reg) &&
@@ -5719,7 +5719,8 @@ static bool is_trusted_reg(const struct bpf_reg_state *reg)
 		return true;
 
 	/* Types listed in the reg2btf_ids are always trusted */
-	if (reg2btf_ids[base_type(reg->type)])
+	if (reg2btf_ids[base_type(reg->type)] &&
+	    !bpf_type_has_unsafe_modifiers(reg->type))
 		return true;
 
 	/* If a register is not referenced, it is trusted if it has the
@@ -6339,6 +6340,7 @@ static int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
 #define BTF_TYPE_SAFE_RCU(__type)  __PASTE(__type, __safe_rcu)
 #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __safe_rcu_or_null)
 #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_trusted)
+#define BTF_TYPE_SAFE_TRUSTED_OR_NULL(__type)  __PASTE(__type, __safe_trusted_or_null)
 
 /*
  * Allow list few fields as RCU trusted or full trusted.
@@ -6402,7 +6404,7 @@ BTF_TYPE_SAFE_TRUSTED(struct dentry) {
 	struct inode *d_inode;
 };
 
-BTF_TYPE_SAFE_TRUSTED(struct socket) {
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
 	struct sock *sk;
 };
 
@@ -6437,11 +6439,20 @@ static bool type_is_trusted(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct linux_binprm));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct file));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct dentry));
-	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct socket));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_trusted");
 }
 
+static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
+				    struct bpf_reg_state *reg,
+				    const char *field_name, u32 btf_id)
+{
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
+
+	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
+					  "__safe_trusted_or_null");
+}
+
 static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *regs,
 				   int regno, int off, int size,
@@ -6550,6 +6561,8 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		 */
 		if (type_is_trusted(env, reg, field_name, btf_id)) {
 			flag |= PTR_TRUSTED;
+		} else if (type_is_trusted_or_null(env, reg, field_name, btf_id)) {
+			flag |= PTR_TRUSTED | PTR_MAYBE_NULL;
 		} else if (in_rcu_cs(env) && !type_may_be_null(reg->type)) {
 			if (type_is_rcu(env, reg, field_name, btf_id)) {
 				/* ignore __rcu tag and mark it MEM_RCU */
diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
index e5e3a8b8dd07..637e75df2e14 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -140,11 +140,12 @@ int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
 	struct local_storage *storage;
+	struct sock *sk = sock->sk;
 
-	if (pid != monitored_pid)
+	if (pid != monitored_pid || !sk)
 		return 0;
 
-	storage = bpf_sk_storage_get(&sk_storage_map, sock->sk, 0, 0);
+	storage = bpf_sk_storage_get(&sk_storage_map, sk, 0, 0);
 	if (!storage)
 		return 0;
 
@@ -155,24 +156,24 @@ int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
 	/* This tests that we can associate multiple elements
 	 * with the local storage.
 	 */
-	storage = bpf_sk_storage_get(&sk_storage_map2, sock->sk, 0,
+	storage = bpf_sk_storage_get(&sk_storage_map2, sk, 0,
 				     BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!storage)
 		return 0;
 
-	if (bpf_sk_storage_delete(&sk_storage_map2, sock->sk))
+	if (bpf_sk_storage_delete(&sk_storage_map2, sk))
 		return 0;
 
-	storage = bpf_sk_storage_get(&sk_storage_map2, sock->sk, 0,
+	storage = bpf_sk_storage_get(&sk_storage_map2, sk, 0,
 				     BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!storage)
 		return 0;
 
-	if (bpf_sk_storage_delete(&sk_storage_map, sock->sk))
+	if (bpf_sk_storage_delete(&sk_storage_map, sk))
 		return 0;
 
 	/* Ensure that the sk_storage_map is disconnected from the storage. */
-	if (!sock->sk->sk_bpf_storage || sock->sk->sk_bpf_storage->smap)
+	if (!sk->sk_bpf_storage || sk->sk_bpf_storage->smap)
 		return 0;
 
 	sk_storage_result = 0;
@@ -185,11 +186,12 @@ int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
 	struct local_storage *storage;
+	struct sock *sk = sock->sk;
 
-	if (pid != monitored_pid)
+	if (pid != monitored_pid || !sk)
 		return 0;
 
-	storage = bpf_sk_storage_get(&sk_storage_map, sock->sk, 0,
+	storage = bpf_sk_storage_get(&sk_storage_map, sk, 0,
 				     BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!storage)
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/lsm_cgroup.c b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
index 02c11d16b692..d7598538aa2d 100644
--- a/tools/testing/selftests/bpf/progs/lsm_cgroup.c
+++ b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
@@ -103,11 +103,15 @@ static __always_inline int real_bind(struct socket *sock,
 				     int addrlen)
 {
 	struct sockaddr_ll sa = {};
+	struct sock *sk = sock->sk;
 
-	if (sock->sk->__sk_common.skc_family != AF_PACKET)
+	if (!sk)
+		return 1;
+
+	if (sk->__sk_common.skc_family != AF_PACKET)
 		return 1;
 
-	if (sock->sk->sk_kern_sock)
+	if (sk->sk_kern_sock)
 		return 1;
 
 	bpf_probe_read_kernel(&sa, sizeof(sa), address);
-- 
2.43.0


