Return-Path: <bpf+bounces-59098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86797AC6059
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFAE3AFD2E
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A99215F53;
	Wed, 28 May 2025 03:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fj7cRkqR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B292135BB;
	Wed, 28 May 2025 03:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404198; cv=none; b=XRneGGEIuVis5ekKiGBNPfMatDyL1Eb4unFQEdGGIyitqzy8kznfRXQmD9TjwCBKjKvgUvd9NLR3bCJ/SRypO3LMtN7RxrEvUlpFi/IiP+vVhGRum9oWQDlHo2rzmHStq0yUVLBLS/g+WCs+3ZlDKzK1eJsOYOcsh2FpibLLRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404198; c=relaxed/simple;
	bh=2qsWsLKzCQWmPBn92SOSDDTtGP108ttyYy+xr/NrD5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e2SCPID3GGEmyKUXOKeHxRPLDm1Y5oaAYR/7zXN37cG3kyqavvLwn0bnfivM3uIph5sIIQSO6B62SIc0LRtxTUfypEos0eEgdmIytYdq+PMHZVFnmqmCbOsFkkH1JVzxZohw/NL7UIUyVVhy87Hcj6GCfg3H5uBO4+8Eiby/EQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fj7cRkqR; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2347d505445so16471895ad.2;
        Tue, 27 May 2025 20:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404196; x=1749008996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2KhlOaE735i3tZSmxmCD+tiCv4kDZN8CVb3bdoSz/Q=;
        b=fj7cRkqRsqazW840Mnfx6iX5pFpZI4sFAoUl+KzjvQ1WEPe9nXrRtoo6KQD0aMcl6x
         fbVuLZOj6YYQMEni7PDB6fTdZvKpIbZ4bnMkwdBgX2pZfaCHCKq3hxRW9OXY3Mii9N3G
         xPY4DMwTlJuZDyY4Bg9KyZXp3Hrgi941vtXrJfOSqrIbqwG6j3DzbwoFeP5GUjvD10Gg
         /N8Vo536m7hF7PdGHOKlensrL+5UxdGdIYA+in3+eecQplhd1H6tSPPhH4IqoN+6Sj/K
         N4EJ+BRMfbG1FB2vCSxMYw7xEfdnXc34+li9s2Uve4S8aZxoV/fRjOPAgFmhsFUvJiq3
         +wPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404196; x=1749008996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2KhlOaE735i3tZSmxmCD+tiCv4kDZN8CVb3bdoSz/Q=;
        b=M/FrEC5mVNnll/Uhj4oEjC/+on6OwktjwFuM8Dgc7xO3oU3H5YvI2pDs8q6FVeOJCh
         7cE6DU9hm7+aD0qt/kmxnp7O2APhoUuYcWvKQKf/fY5ltu9Bv3ZCIPPbL850ufjA7S4O
         1EDJMr3gF6UcvGLKfnVtyste1nnyw8644/7L04N0bHGtsgnGZ36tPlIv7WfflQIlaDcS
         G3xJAVaKDmIsYSsFDSdNqJd3C5QFAvRE3Yo++Ve2OPUq801WqdhNGeTzR5Ouh5VAVdzq
         4K2o+yh8x4byCHgUEr9xOwsoEtz3oq15xZUY7tYg3xZnqju0Ix9FZcnMhf5Sd8HoH7V/
         dDLw==
X-Forwarded-Encrypted: i=1; AJvYcCUrcTWByDGsjSbCDHLXvS8iul8VLydCoPc6rWqd+imdmVj9wCeBqKIX4IW1RrQzhec1+l7kETUoEdGegRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2u55m0vIWLcmqNx5YinyfFi/SI7UlMFx7kQuAqmcLuPg8tRY1
	Iuk8XYLscbg9pkq9xLmEY3BWhPRX16jCRUt607uRpd4fKbPfMyVW13Ng
X-Gm-Gg: ASbGncv5UtwY0svP6967PdWKll9uicTdh021rcvYcn9V6TRvGNhu0tkS5IZ3yEFUb+Q
	R1ht8y8FDGn8GFqCQCXwoi3X0oz3JW1RRW2qtln+4f3PzA5Bdl5+8Jp1uHcoE+mzsOua8W8OpxF
	MCPR/vf9NpSHQoU0O3eKRBnv8FCPEcQgwxoNj4XKyjQdJG2a24YUMZySLYAzNUJCKPDd8TT/3bv
	j951pTgl2bz/hxz5wB4yBh90rk+M+p97DR+usRmO9KzmUzk8CZDhUQ6X60NoesoJY0NggWbq892
	07ojhzPRrV3D2QnpOYNT5IdFqVY3+QdP2Oh1tQC0Y7yOl9sX1i+39zuZ0RixfCcO+kFf
X-Google-Smtp-Source: AGHT+IF2BYBHNpymSQL9fQ8dcUhjPfH7A+R7PWRcP7iUBtt9L1t/RZGT/4upzoc1pvqrNcdXfIaUYQ==
X-Received: by 2002:a17:902:dac4:b0:231:c90e:292d with SMTP id d9443c01a7336-23414fe34admr222979455ad.44.1748404196070;
        Tue, 27 May 2025 20:49:56 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:49:55 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 09/25] bpf: tracing: add support to record and check the accessed args
Date: Wed, 28 May 2025 11:46:56 +0800
Message-Id: <20250528034712.138701-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528034712.138701-1-dongml2@chinatelecom.cn>
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, we add the 'accessed_args' field to struct bpf_prog_aux,
which is used to record the accessed index of the function args in
btf_ctx_access().

Meanwhile, we add the function btf_check_func_part_match() to compare the
accessed function args of two function prototype. This function will be
used in the following commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/bpf.h |   4 ++
 kernel/bpf/btf.c    | 108 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7527399bab5b..abf504e95ff2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1601,6 +1601,7 @@ struct bpf_prog_aux {
 	const struct btf_type *attach_func_proto;
 	/* function name for valid attach_btf_id */
 	const char *attach_func_name;
+	u64 accessed_args;
 	struct bpf_prog **func;
 	void *jit_data; /* JIT specific data. arch dependent */
 	struct bpf_jit_poke_descriptor *poke_tab;
@@ -2779,6 +2780,9 @@ struct bpf_reg_state;
 int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog);
 int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *prog,
 			 struct btf *btf, const struct btf_type *t);
+int btf_check_func_part_match(struct btf *btf1, const struct btf_type *t1,
+			      struct btf *btf2, const struct btf_type *t2,
+			      u64 func_args);
 const char *btf_find_decl_tag_value(const struct btf *btf, const struct btf_type *pt,
 				    int comp_idx, const char *tag_key);
 int btf_find_next_decl_tag(const struct btf *btf, const struct btf_type *pt,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0f7828380895..64538625ee91 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6392,19 +6392,24 @@ static bool is_void_or_int_ptr(struct btf *btf, const struct btf_type *t)
 }
 
 static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
-			   int off)
+			   int off, int *aligned_idx)
 {
 	const struct btf_param *args;
 	const struct btf_type *t;
 	u32 offset = 0, nr_args;
 	int i;
 
+	if (aligned_idx)
+		*aligned_idx = -ENOENT;
+
 	if (!func_proto)
 		return off / 8;
 
 	nr_args = btf_type_vlen(func_proto);
 	args = (const struct btf_param *)(func_proto + 1);
 	for (i = 0; i < nr_args; i++) {
+		if (aligned_idx && offset == off)
+			*aligned_idx = i;
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
 		offset += btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
 		if (off < offset)
@@ -6671,7 +6676,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			tname, off);
 		return false;
 	}
-	arg = get_ctx_arg_idx(btf, t, off);
+	arg = get_ctx_arg_idx(btf, t, off, NULL);
 	args = (const struct btf_param *)(t + 1);
 	/* if (t == NULL) Fall back to default BPF prog with
 	 * MAX_BPF_FUNC_REG_ARGS u64 arguments.
@@ -6681,6 +6686,9 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		/* skip first 'void *__data' argument in btf_trace_##name typedef */
 		args++;
 		nr_args--;
+		prog->aux->accessed_args |= (1 << (arg + 1));
+	} else {
+		prog->aux->accessed_args |= (1 << arg);
 	}
 
 	if (arg > nr_args) {
@@ -7540,6 +7548,102 @@ int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *pr
 	return btf_check_func_type_match(log, btf1, t1, btf2, t2);
 }
 
+static u32 get_ctx_arg_total_size(struct btf *btf, const struct btf_type *t)
+{
+	const struct btf_param *args;
+	u32 size = 0, nr_args;
+	int i;
+
+	nr_args = btf_type_vlen(t);
+	args = (const struct btf_param *)(t + 1);
+	for (i = 0; i < nr_args; i++) {
+		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
+		size += btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
+	}
+
+	return size;
+}
+
+/* This function is similar to btf_check_func_type_match(), except that it
+ * only compare some function args of the function prototype t1 and t2.
+ */
+int btf_check_func_part_match(struct btf *btf1, const struct btf_type *func1,
+			      struct btf *btf2, const struct btf_type *func2,
+			      u64 func_args)
+{
+	const struct btf_param *args1, *args2;
+	u32 nargs1, i, offset = 0;
+	const char *s1, *s2;
+
+	if (!btf_type_is_func_proto(func1) || !btf_type_is_func_proto(func2))
+		return -EINVAL;
+
+	args1 = (const struct btf_param *)(func1 + 1);
+	args2 = (const struct btf_param *)(func2 + 1);
+	nargs1 = btf_type_vlen(func1);
+
+	for (i = 0; i <= nargs1; i++) {
+		const struct btf_type *t1, *t2;
+
+		if (!(func_args & (1 << i)))
+			goto next;
+
+		if (i < nargs1) {
+			int t2_index;
+
+			/* get the index of the arg corresponding to args1[i]
+			 * by the offset.
+			 */
+			get_ctx_arg_idx(btf2, func2, offset, &t2_index);
+			if (t2_index < 0)
+				return -EINVAL;
+
+			t1 = btf_type_skip_modifiers(btf1, args1[i].type, NULL);
+			t2 = btf_type_skip_modifiers(btf2, args2[t2_index].type,
+						     NULL);
+		} else {
+			/* i == nargs1, this is the index of return value of t1 */
+			if (get_ctx_arg_total_size(btf1, func1) !=
+			    get_ctx_arg_total_size(btf2, func2))
+				return -EINVAL;
+
+			/* check the return type of t1 and t2 */
+			t1 = btf_type_skip_modifiers(btf1, func1->type, NULL);
+			t2 = btf_type_skip_modifiers(btf2, func2->type, NULL);
+		}
+
+		if (t1->info != t2->info ||
+		    (btf_type_has_size(t1) && t1->size != t2->size))
+			return -EINVAL;
+		if (btf_type_is_int(t1) || btf_is_any_enum(t1))
+			goto next;
+
+		if (btf_type_is_struct(t1))
+			goto on_struct;
+
+		if (!btf_type_is_ptr(t1))
+			return -EINVAL;
+
+		t1 = btf_type_skip_modifiers(btf1, t1->type, NULL);
+		t2 = btf_type_skip_modifiers(btf2, t2->type, NULL);
+		if (!btf_type_is_struct(t1) || !btf_type_is_struct(t2))
+			return -EINVAL;
+
+on_struct:
+		s1 = btf_name_by_offset(btf1, t1->name_off);
+		s2 = btf_name_by_offset(btf2, t2->name_off);
+		if (strcmp(s1, s2))
+			return -EINVAL;
+next:
+		if (i < nargs1) {
+			t1 = btf_type_skip_modifiers(btf1, args1[i].type, NULL);
+			offset += btf_type_is_ptr(t1) ? 8 : roundup(t1->size, 8);
+		}
+	}
+
+	return 0;
+}
+
 static bool btf_is_dynptr_ptr(const struct btf *btf, const struct btf_type *t)
 {
 	const char *name;
-- 
2.39.5


