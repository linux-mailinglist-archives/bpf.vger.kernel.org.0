Return-Path: <bpf+bounces-28005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B498B433C
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 02:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CC61C22DC7
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 00:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B046AD6;
	Sat, 27 Apr 2024 00:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEUqKgrP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51816523D
	for <bpf@vger.kernel.org>; Sat, 27 Apr 2024 00:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714177551; cv=none; b=LY3UvKYmINuM1EgraWzfI0erbs7lkH0b0CRiK0hMr69cVwUhDSZrAeNBsROaTUPXR4JP1wxTwyQEy6mCCLuisn3fN/TD6Y2IskdinBL7Es1raYtOZc0gd9IEKqt+uUULRkpmLNwqy2KlN8HqvW8UQfZq9Fpms9zZZuTwqHLSm5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714177551; c=relaxed/simple;
	bh=m+D2gp2VRasGcUIEbYUd8eldPY0x55zRpr9kvDLwTTU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=klHBcmmRodaP5uEWcjLrnIb4009HtijRceTwvsOhG1jv3wXYfdMzv2p5lnx0o+9bXXn8U+S0XXn0ADbbu01DvoDIXg0x2N/ryAal/ZF/epPrO9C7Lpya+AQRR7F8dcdSOBEq1Tfg73zNZdq1sEjHqfrdpL/cQVO0G9D06RluHBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEUqKgrP; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6eb8ea5ac95so1722382a34.2
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 17:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714177549; x=1714782349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wmIJhsm3TfApdPmSuFafwCUb61EEkDJLPiQnx92Jk3o=;
        b=nEUqKgrPN3lKzX+AOlvVHqmMIP5YqP3IFBG6XTa960WSONJtekDWHm7fxLzJaXSuBu
         A0JJwmv9tRj5ftG0m7BXBk6z+CxktFL7F6O5TApQxvq0IpfYrrst594wRomu1xdIl/hr
         zHmQvKWpB1sICRgSfmC9NeAXzAag9m5LMqqjMYFAI/d0yRUQxOfiBQRztePr6mNVfSUK
         ehLb3uIbz3zh6uLL5rT+HH3hpOOS+XMczRIgkGjYkWtdxr8/8EzyD0x2sfLf5kP+MIM7
         0L7CmIfeyyTXMOycE5MZS6YAkNV27dpZ7JOPaDoqfDQPWTeMiQYPugzW5WD1tegXOJrS
         zZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714177549; x=1714782349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmIJhsm3TfApdPmSuFafwCUb61EEkDJLPiQnx92Jk3o=;
        b=WE/y7MdIcPlKpzT74oAvd6x4wvX4j/Esu20kv4hovRx+ou5wVZcCJ/gK+LMx5WiacC
         dEUQ53jFd88o8nhNLK4BJt19nafXktAQuWR+5Ou/dm+cN76sFeWhBe24YBE4Ku44mX5a
         4CuMDEHP/RPFHNbFyIAFOhM272p+JPV8+u1vZdePlyvORTE8iWojbFRb6TnmU3TtcyQG
         +FOUCXWniAIgPzElS6hcrJC2Ehgbcj9Ckj3wANSJ46DmdNPA0caAvljDAphwKxnoPTnF
         T31WYshObo2xj38Qr9G+aa1rk0BZmv42VLauj0XixPW79WuQJ6kO9zbQs8lXzlC/wJRb
         D3HA==
X-Gm-Message-State: AOJu0YyPazRJDQFrOa+h3I5TAvnBZo3hEKSkQSoUNOdyRGLiV5fVdhsX
	vB1S3az9vyz0XFonm306B+Y56VCtvdDiytU379xwV4juj4FHbOMVOfyeCg==
X-Google-Smtp-Source: AGHT+IEV/V7Up42uiue8iN1KFSDg3PjeyNVkOWpWRUx3l0CeW1CDkM0dSX3A4GREd9p5Emhh4eZPZA==
X-Received: by 2002:a05:6830:16d8:b0:6ec:fe4e:607d with SMTP id l24-20020a05683016d800b006ecfe4e607dmr4354789otr.9.1714177548693;
        Fri, 26 Apr 2024 17:25:48 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:1db6])
        by smtp.gmail.com with ESMTPSA id b16-20020a63d810000000b005e438fe702dsm14980895pgh.65.2024.04.26.17.25.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Apr 2024 17:25:48 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	liamwisehart@meta.com,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next] bpf: Fix verifier assumptions about socket->sk
Date: Fri, 26 Apr 2024 17:25:44 -0700
Message-Id: <20240427002544.68803-1-alexei.starovoitov@gmail.com>
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
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
v1->v2: Fixed bench_local_storage_create.c
---
 kernel/bpf/verifier.c                         | 23 +++++++++++++++----
 .../bpf/progs/bench_local_storage_create.c    |  5 ++--
 .../selftests/bpf/progs/local_storage.c       | 20 ++++++++--------
 .../testing/selftests/bpf/progs/lsm_cgroup.c  |  8 +++++--
 4 files changed, 38 insertions(+), 18 deletions(-)

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
diff --git a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
index e4bfbba6c193..c8ec0d0368e4 100644
--- a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
+++ b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
@@ -61,14 +61,15 @@ SEC("lsm.s/socket_post_create")
 int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 	     int protocol, int kern)
 {
+	struct sock *sk = sock->sk;
 	struct storage *stg;
 	__u32 pid;
 
 	pid = bpf_get_current_pid_tgid() >> 32;
-	if (pid != bench_pid)
+	if (pid != bench_pid || !sk)
 		return 0;
 
-	stg = bpf_sk_storage_get(&sk_storage_map, sock->sk, NULL,
+	stg = bpf_sk_storage_get(&sk_storage_map, sk, NULL,
 				 BPF_LOCAL_STORAGE_GET_F_CREATE);
 
 	if (stg)
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


