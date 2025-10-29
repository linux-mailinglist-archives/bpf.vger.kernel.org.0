Return-Path: <bpf+bounces-72858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E6DC1CDF1
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 20:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E25094E2483
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECD6351FD7;
	Wed, 29 Oct 2025 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UiPlh9f/"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189B62EC54D
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764514; cv=none; b=QC1EkiKn7fyAaK2vn7C10zsVBNDVzEm4WqDtKiRbQwDcRdh55tNYdRvmLIW8LLufzdj699YKG8qBcS565OgeK/1LarcZcMXRxsLPqWmrxI6h14Q5GCggepU7Egg1ahAb8osenRo0oaMJrCM6CbiOKm4O2pQSm7PWxtsZlBf+cK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764514; c=relaxed/simple;
	bh=X9K9958Th7ZERACPMaWTJIQp4Iu9B+ISfiAoVHJ0AIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1TrL5PiN4fw4tf49RIdoUpYOt5xqMhWn8lBaqM/SKBix+Vr/G+HsGy5YW2WRWeer2eMZ/X8yEKQzs0adV0SP2jF81aT0IkaNmEhcOlyEug9rSgkZJ8tPmGFSRbpzte8SRiKrzmvDO22wB1AGfrp4e22pKanE7RH6Tm7S4MUeYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UiPlh9f/; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761764511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+7mGy4joK8EgILjQ7whtp3xAcorFzWp11bFTaG8+SE=;
	b=UiPlh9f/jTwHBxn8eHkZqYuq7HkMD2uhDbSI1vDsW64XU89ikUybFtRAHkqQ28gCKHTF8c
	3Lx9MTYarLRkjUb+Fc6oYAk6SMSZaiQLjAylS2xZWH7BfgCCa9LmPPTQ1rXWQ69UhR1FU6
	CTUFH+zis1fHDbVPqGogpkRbLlvQECk=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org
Cc: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com,
	tj@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 4/8] bpf: Support __magic prog_aux arguments for kfuncs
Date: Wed, 29 Oct 2025 12:01:09 -0700
Message-ID: <20251029190113.3323406-5-ihor.solodrai@linux.dev>
In-Reply-To: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Teach the verifier that the prog_aux argument of a kfunc can be
specified with __magic suffix, in which case the type of the function
parameter must be checked.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/verifier.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fcf0872b9e3d..67914464d503 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12136,9 +12136,12 @@ static bool is_kfunc_arg_magic(const struct btf *btf, const struct btf_param *ar
 	return btf_param_match_suffix(btf, arg, "__magic");
 }
 
+static bool is_kfunc_arg_prog_aux(const struct btf *btf, const struct btf_param *arg);
+
 static bool is_kfunc_arg_prog(const struct btf *btf, const struct btf_param *arg)
 {
-	return btf_param_match_suffix(btf, arg, "__prog");
+	return btf_param_match_suffix(btf, arg, "__prog") ||
+	       (is_kfunc_arg_magic(btf, arg) && is_kfunc_arg_prog_aux(btf, arg));
 }
 
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
@@ -12169,6 +12172,7 @@ enum {
 	KF_ARG_WORKQUEUE_ID,
 	KF_ARG_RES_SPIN_LOCK_ID,
 	KF_ARG_TASK_WORK_ID,
+	KF_ARG_PROG_AUX_ID
 };
 
 BTF_ID_LIST(kf_arg_btf_ids)
@@ -12180,6 +12184,7 @@ BTF_ID(struct, bpf_rb_node)
 BTF_ID(struct, bpf_wq)
 BTF_ID(struct, bpf_res_spin_lock)
 BTF_ID(struct, bpf_task_work)
+BTF_ID(struct, bpf_prog_aux)
 
 static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
 				    const struct btf_param *arg, int type)
@@ -12260,6 +12265,11 @@ static bool is_kfunc_arg_callback(struct bpf_verifier_env *env, const struct btf
 	return true;
 }
 
+static bool is_kfunc_arg_prog_aux(const struct btf *btf, const struct btf_param *arg)
+{
+	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_PROG_AUX_ID);
+}
+
 /* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
 static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
 					const struct btf *btf,
-- 
2.51.1


