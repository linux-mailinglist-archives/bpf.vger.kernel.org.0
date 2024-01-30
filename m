Return-Path: <bpf+bounces-20641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B3E84174C
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 01:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACADB285A7F
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 00:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA1D10FD;
	Tue, 30 Jan 2024 00:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZT2PoWh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5A7D266
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 00:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706573219; cv=none; b=LaFbAuRTkSWs9n64VBAxNmOLMJaD1x6C7SswnyBUAQEiAqqcIwsmPvMK/v0Gg965cxo/iQUXrA5ZQ4XByNRRmj9e5+D+lKAOcFpWrnb6+GCcH7eMN18djwT0S+aOTQJqq5fIstPfkFyMUx7cXV/bdZB2WHpk3emJyiCI2qaRZ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706573219; c=relaxed/simple;
	bh=3A7J0deHOq9ndLUf6W4Tt756O0NcriTdTq6umqVTSmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mVbryuYGtk03Ebm8ZK51MMmFWtC13YwWL8pCbw8Nqv5eCCFwB0IgeduQgpNhFIKIsl65vUu0zti8pDNIARYQGEeVSL2+vVC4sxpuJVnruYxyIf4HsozCF7ypOFVVW0dyRZigXqiz4l0k7eC6gKqFB/hOR/yZ9lC4HKty7FkEi5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZT2PoWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EE1C433F1;
	Tue, 30 Jan 2024 00:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706573219;
	bh=3A7J0deHOq9ndLUf6W4Tt756O0NcriTdTq6umqVTSmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DZT2PoWhvsBPk0Wy83duMXGM5zDc/MUfc5AOrMywwSfNGGr/HVHJnZCNVSz85eodi
	 gKp70g50qvpL2u04LeJ/Zs+NfvE4N0eP33raVKDTVumQcsj+PoF/eXrOn9MDvrNet7
	 N94r2kuGth5rkonJtUjpw2prbGBFpIXu3xLEnmUSrKH7jcEmrq7A5jxfwkWSNO0qti
	 nroEvL1UjNkRsCX/EZcdtccCHbrBwwW/q2+g44G7MIS5gnIMhJyfVlsiYRQPnzUmql
	 pX9W0JBDrLDglxsfoOT8JX3FSYUkweAXGcIlAu3Q5NKx7xUY1idQFLpFdtoRdEM3At
	 WNvr//qs7WCXQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v3 bpf-next 2/4] bpf: add arg:nullable tag to be combined with trusted pointers
Date: Mon, 29 Jan 2024 16:06:46 -0800
Message-Id: <20240130000648.2144827-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130000648.2144827-1-andrii@kernel.org>
References: <20240130000648.2144827-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ability to mark arg:trusted arguments with optional arg:nullable
tag to mark it as PTR_TO_BTF_ID_OR_NULL variant, which will allow
callers to pass NULL, and subsequently will force global subprog's code
to do NULL check. This allows to have "optional" PTR_TO_BTF_ID values
passed into global subprogs.

For now arg:nullable cannot be combined with anything else.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/btf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ed7a05815984..c8c6e6cf18e7 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7056,6 +7056,7 @@ enum btf_arg_tag {
 	ARG_TAG_CTX = 0x1,
 	ARG_TAG_NONNULL = 0x2,
 	ARG_TAG_TRUSTED = 0x4,
+	ARG_TAG_NULLABLE = 0x8,
 };
 
 /* Process BTF of a function to produce high-level expectation of function
@@ -7161,6 +7162,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 				tags |= ARG_TAG_TRUSTED;
 			} else if (strcmp(tag, "nonnull") == 0) {
 				tags |= ARG_TAG_NONNULL;
+			} else if (strcmp(tag, "nullable") == 0) {
+				tags |= ARG_TAG_NULLABLE;
 			} else {
 				bpf_log(log, "arg#%d has unsupported set of tags\n", i);
 				return -EOPNOTSUPP;
@@ -7210,12 +7213,19 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 				return kern_type_id;
 
 			sub->args[i].arg_type = ARG_PTR_TO_BTF_ID | PTR_TRUSTED;
+			if (tags & ARG_TAG_NULLABLE)
+				sub->args[i].arg_type |= PTR_MAYBE_NULL;
 			sub->args[i].btf_id = kern_type_id;
 			continue;
 		}
 		if (is_global) { /* generic user data pointer */
 			u32 mem_size;
 
+			if (tags & ARG_TAG_NULLABLE) {
+				bpf_log(log, "arg#%d has invalid combination of tags\n", i);
+				return -EINVAL;
+			}
+
 			t = btf_type_skip_modifiers(btf, t->type, NULL);
 			ref_t = btf_resolve_size(btf, t, &mem_size);
 			if (IS_ERR(ref_t)) {
-- 
2.34.1


