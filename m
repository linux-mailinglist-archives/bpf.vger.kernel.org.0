Return-Path: <bpf+bounces-36733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A27B94C752
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 01:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2E60B22848
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 23:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3FC15FA92;
	Thu,  8 Aug 2024 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skelZJpJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6555B1474A5
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723159360; cv=none; b=RgjxPZQwXXco5c1MRJLtj6RXZ5yP9R+/LB5bStjQvbh0h5RUo11lTxfsr1daQEIroDKLvcwI4NnhYzcL4THGfOGTbdlv0/dTqoF1w5UegAOl0kGlRDKnSKFAtwJxda4htUF44jg9toHvD/gI6RgAThIW0r51KiylaqfX8svCmSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723159360; c=relaxed/simple;
	bh=pC2mhpuGsLUDJelueCYERt9ERK5ZDHncNvQBaLaZFRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dx+dHRv/kkjeOJ1XgFF9KHP2BqymPSY/K+AWAIqX4P70lPMmQ2BNkuxVA6e51EJ8W4yGmLIJ2BbaP/vEhFFuvITg0kv2Vzy/Tpc8zJ4OAezQfvoLzKIXY4q7hKmbwTPY3iUpoNXoyhKQMIIOwczorWCozxJQ5GDwf8Xr2cYRQOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skelZJpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C740EC32782;
	Thu,  8 Aug 2024 23:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723159359;
	bh=pC2mhpuGsLUDJelueCYERt9ERK5ZDHncNvQBaLaZFRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=skelZJpJ3PnMyO1OLjUSyYFe4l0biHQWQj89uU0Ewt1Ax0FY5Z+HxfBHYSNAerYHN
	 tNcGIWHhZYYfT9E3kHikb5t6ja+VEL6TFRY6LQEgoWvozKPxmLycnUpfo7ytR/UKQ7
	 1i6EX5uBkdUZdo0YUmMVmGXlPHgz/SfI0GBw9rj4M4guzyjbOPt9t9p2eXPnHXTDFg
	 1kFHOKuIASRtUXXmyUqIG+3p1s7/0wcVnkeuBqmxtD9AZNaK7IWjSdhOvvARQkd42p
	 POtf8WKUSARO58Lin5PccSG2ILDMHlLFiScZK+64wrokH+JmkcGGaIM0cInsXxWeTT
	 wNU83SH0KCNsg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: tj@kernel.org,
	void@manifault.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 1/3] bpf: extract iterator argument type and name validation logic
Date: Thu,  8 Aug 2024 16:22:28 -0700
Message-ID: <20240808232230.2848712-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240808232230.2848712-1-andrii@kernel.org>
References: <20240808232230.2848712-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verifier enforces that all iterator structs are named `bpf_iter_<name>`
and that whenever iterator is passed to a kfunc it's passed as a valid PTR ->
STRUCT chain (with potentially const modifiers in between).

We'll need this check for upcoming changes, so instead of duplicating
the logic, extract it into a helper function.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/btf.h |  5 +++++
 kernel/bpf/btf.c    | 50 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index cffb43133c68..b8a583194c4a 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -580,6 +580,7 @@ bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_type);
 bool btf_types_are_same(const struct btf *btf1, u32 id1,
 			const struct btf *btf2, u32 id2);
+int btf_check_iter_arg(struct btf *btf, const struct btf_type *func, int arg_idx);
 #else
 static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
 						    u32 type_id)
@@ -654,6 +655,10 @@ static inline bool btf_types_are_same(const struct btf *btf1, u32 id1,
 {
 	return false;
 }
+static inline int btf_check_iter_arg(struct btf *btf, const struct btf_type *func, int arg_idx)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type *t)
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 95426d5b634e..f544acf92521 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8052,15 +8052,44 @@ BTF_ID_LIST_GLOBAL(btf_tracing_ids, MAX_BTF_TRACING_TYPE)
 BTF_TRACING_TYPE_xxx
 #undef BTF_TRACING_TYPE
 
+/* Validate well-formedness of iter argument type.
+ * On success, return positive BTF ID of iter state's STRUCT type.
+ * On error, negative error is returned.
+ */
+int btf_check_iter_arg(struct btf *btf, const struct btf_type *func, int arg_idx)
+{
+	const struct btf_param *arg;
+	const struct btf_type *t;
+	const char *name;
+	int btf_id;
+
+	if (btf_type_vlen(func) <= arg_idx)
+		return -EINVAL;
+
+	arg = &btf_params(func)[arg_idx];
+	t = btf_type_skip_modifiers(btf, arg->type, NULL);
+	if (!t || !btf_type_is_ptr(t))
+		return -EINVAL;
+	t = btf_type_skip_modifiers(btf, t->type, &btf_id);
+	if (!t || !__btf_type_is_struct(t))
+		return -EINVAL;
+
+	name = btf_name_by_offset(btf, t->name_off);
+	if (!name || strncmp(name, ITER_PREFIX, sizeof(ITER_PREFIX) - 1))
+		return -EINVAL;
+
+	return btf_id;
+}
+
 static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
 				 const struct btf_type *func, u32 func_flags)
 {
 	u32 flags = func_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY);
-	const char *name, *sfx, *iter_name;
-	const struct btf_param *arg;
+	const char *sfx, *iter_name;
 	const struct btf_type *t;
 	char exp_name[128];
 	u32 nr_args;
+	int btf_id;
 
 	/* exactly one of KF_ITER_{NEW,NEXT,DESTROY} can be set */
 	if (!flags || (flags & (flags - 1)))
@@ -8071,28 +8100,21 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
 	if (nr_args < 1)
 		return -EINVAL;
 
-	arg = &btf_params(func)[0];
-	t = btf_type_skip_modifiers(btf, arg->type, NULL);
-	if (!t || !btf_type_is_ptr(t))
-		return -EINVAL;
-	t = btf_type_skip_modifiers(btf, t->type, NULL);
-	if (!t || !__btf_type_is_struct(t))
-		return -EINVAL;
-
-	name = btf_name_by_offset(btf, t->name_off);
-	if (!name || strncmp(name, ITER_PREFIX, sizeof(ITER_PREFIX) - 1))
-		return -EINVAL;
+	btf_id = btf_check_iter_arg(btf, func, 0);
+	if (btf_id < 0)
+		return btf_id;
 
 	/* sizeof(struct bpf_iter_<type>) should be a multiple of 8 to
 	 * fit nicely in stack slots
 	 */
+	t = btf_type_by_id(btf, btf_id);
 	if (t->size == 0 || (t->size % 8))
 		return -EINVAL;
 
 	/* validate bpf_iter_<type>_{new,next,destroy}(struct bpf_iter_<type> *)
 	 * naming pattern
 	 */
-	iter_name = name + sizeof(ITER_PREFIX) - 1;
+	iter_name = btf_name_by_offset(btf, t->name_off) + sizeof(ITER_PREFIX) - 1;
 	if (flags & KF_ITER_NEW)
 		sfx = "new";
 	else if (flags & KF_ITER_NEXT)
-- 
2.43.5


