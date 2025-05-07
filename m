Return-Path: <bpf+bounces-57634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A54FAAD654
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 08:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412A33A9238
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 06:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D6B2116FB;
	Wed,  7 May 2025 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdYhf4Ce"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5C720B218
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 06:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746600073; cv=none; b=rxa9Vew0ST8Hivf4LOMbrM5MnBePvYyKC1yBBg6bcwTHhREPTLI6FJLLqTD7JAP+wCNHVRM+LfCkj6RHOEE+EZy1mrurEIWz5j0aTVMWpZjsCZ3OcPtf/D4iBKNZTxwVn5sjITwD0FE76anO8OlhxYk+EtkrQN1dB+Se+K71JNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746600073; c=relaxed/simple;
	bh=LJUx3PgAWkz5gPzV4a1/ZlHGtEi1VyFX2L8ogCfMSxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEIFJpIbcPtt4D0WKH1pKXA838r47pryRkfcrtvLfngLTZ9f+R1Em2wVQQhbGehagtsiPdqiBoLFCcd4ak9G6Cvj99k+/+CMwKN36B7YYxLACCtj9q1WCS5oZUjldsCdNyQDKv5dKhLa853IQKdO4afDXPokfyWQSHqrIgE+Y64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VdYhf4Ce; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746600070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jb6fk91sTpiMvjT0ZIVrgcZ8vOi1elonRkoOAsK7BCE=;
	b=VdYhf4CemvJGTKTvsTCwqXhOyfoJUE8pJD7vtxPEdUs+sah7CkCm7yX5MZK9Q0drjEQ8d1
	XDLAM0w7oogcyaeAOMh9XnY+7ag2Wd8bsYHqrLv7iVit+EqVGhDKMYugplDL8Yi/LsW3rh
	xxGxCGZAUtFA1JdxbjAmnCtbyLAta+E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-0P8HvCzRMHO8IS08Hs5B_A-1; Wed,
 07 May 2025 02:41:03 -0400
X-MC-Unique: 0P8HvCzRMHO8IS08Hs5B_A-1
X-Mimecast-MFC-AGG-ID: 0P8HvCzRMHO8IS08Hs5B_A_1746600061
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEB5219560BC;
	Wed,  7 May 2025 06:41:00 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.220])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14EEF18003FD;
	Wed,  7 May 2025 06:40:55 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v4 1/4] bpf: Teach vefier to handle const ptrs as args to kfuncs
Date: Wed,  7 May 2025 08:40:36 +0200
Message-ID: <1497b70f2a948fe29559c6bfb03551a7cc8638f1.1746598898.git.vmalik@redhat.com>
In-Reply-To: <cover.1746598898.git.vmalik@redhat.com>
References: <cover.1746598898.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When a kfunc takes a const pointer as an argument, the verifier should
not check that the memory can be accessed for writing as that may lead
to rejecting safe programs. Extend the verifier to detect such arguments
and skip the write access check for them.

The use-case for this change is passing string literals (i.e. read-only
maps) to read-only string kfuncs.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 include/linux/btf.h   |  5 +++++
 kernel/bpf/verifier.c | 10 ++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index ebc0c0c9b944..5cb06c65d91f 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -391,6 +391,11 @@ static inline bool btf_type_is_type_tag(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) == BTF_KIND_TYPE_TAG;
 }
 
+static inline bool btf_type_is_const(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_CONST;
+}
+
 /* union is only a special case of struct:
  * all its offsetof(member) == 0
  */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 54c6953a8b84..e2d74c4d44c1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8186,7 +8186,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 }
 
 static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-			 u32 regno, u32 mem_size)
+			 u32 regno, u32 mem_size, bool read_only)
 {
 	bool may_be_null = type_may_be_null(reg->type);
 	struct bpf_reg_state saved_reg;
@@ -8205,7 +8205,8 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 	}
 
 	err = check_helper_mem_access(env, regno, mem_size, BPF_READ, true, NULL);
-	err = err ?: check_helper_mem_access(env, regno, mem_size, BPF_WRITE, true, NULL);
+	if (!read_only)
+		err = err ?: check_helper_mem_access(env, regno, mem_size, BPF_WRITE, true, NULL);
 
 	if (may_be_null)
 		*reg = saved_reg;
@@ -10361,7 +10362,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
 			if (ret < 0)
 				return ret;
-			if (check_mem_reg(env, reg, regno, arg->mem_size))
+			if (check_mem_reg(env, reg, regno, arg->mem_size, false))
 				return -EINVAL;
 			if (!(arg->arg_type & PTR_MAYBE_NULL) && (reg->type & PTR_MAYBE_NULL)) {
 				bpf_log(log, "arg#%d is expected to be non-NULL\n", i);
@@ -13252,7 +13253,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					i, btf_type_str(ref_t), ref_tname, PTR_ERR(resolve_ret));
 				return -EINVAL;
 			}
-			ret = check_mem_reg(env, reg, regno, type_size);
+			ret = check_mem_reg(env, reg, regno, type_size,
+					    btf_type_is_const(btf_type_by_id(btf, t->type)));
 			if (ret < 0)
 				return ret;
 			break;
-- 
2.49.0


