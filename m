Return-Path: <bpf+bounces-20347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7373D83CDDD
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 21:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A511D1C25C23
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 20:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490AA1386B9;
	Thu, 25 Jan 2024 20:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKGT1gl1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C501339BD
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216128; cv=none; b=HcKSDkyMG/T5cZV3aCX7ECzMD+Sf1aIT0D9JkPATaw7LBL9iXG8jfzHNkWdvexeHySeOnuNGfgRrgJ1TACXMh2D0uv9ca75pGggrlKYfExftI4tEiRAiIuz9A7Bhiq93lZl+2KcXMY/rDWbBjcpk/4tuxkxgY31c4OxpCBnnaEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216128; c=relaxed/simple;
	bh=gOvuf0rYKXRiuxInwlyrMw2xlgnRYmf4YVSy0Fw0k98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=itNCbrGMFkekwiM5iqz4xcE5jADiY37TH0nGNozK5cyBIlhcu/kAw55yUU9mkPeSFb2609/gXd9yLtNpxhSAxJ+n4ttCpFrbeylGYck8yqEKAutM0fKbOEXSUPOTgpa+4vK45FhWXMQC721VrHlDPjwdoWgnP4c87Uxn8WjcvH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKGT1gl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7D0C433C7;
	Thu, 25 Jan 2024 20:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706216128;
	bh=gOvuf0rYKXRiuxInwlyrMw2xlgnRYmf4YVSy0Fw0k98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IKGT1gl1uNRTCPljIfdW/JbaXKKu6VgZLGMiE157qJfaWZAb+FsQsyAue/H4YN9/e
	 /M6+fDhh7fdQAiQnHNaEijyLr1HyOEImoCGYH6v7CjJeRvBlm5z+dAmgkCTHTjI3hO
	 MeQFUUrzsagTnmzPnJPVeEiV4GnDYBErQEI8hVFry499olqslofTfACj7GheS1Dvk4
	 tj7xVv7KVq2mKiEjkofB0LPWcTZ4NzqsDsjqqDv/yIStvBlr1Ky6i5japcpeCs6FaK
	 vEfPVRHD2xYHBcIsLaTGlbWieVMR1UreLUMO/PNWN4KU8by20aE6vjGSD3NOS4jyCs
	 J6wlxB0xtEseg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 5/7] bpf: add arg:maybe_null tag to be combined with trusted pointers
Date: Thu, 25 Jan 2024 12:55:08 -0800
Message-Id: <20240125205510.3642094-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125205510.3642094-1-andrii@kernel.org>
References: <20240125205510.3642094-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ability to mark arg:trusted arguments with optional arg:maybe_null
tag to mark is as PTR_TO_BTF_ID_OR_NULL variant, which will allow
callers to pass NULL, and subsequently will force global subprog's code
to do NULL check. This allows to have "optional" PTR_TO_BTF_ID values
passed into global subprogs.

For now arg:maybe_null cannot be combined with anything else.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/btf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ed7a05815984..270804ece93c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7056,6 +7056,7 @@ enum btf_arg_tag {
 	ARG_TAG_CTX = 0x1,
 	ARG_TAG_NONNULL = 0x2,
 	ARG_TAG_TRUSTED = 0x4,
+	ARG_TAG_MAYBE_NULL = 0x8,
 };
 
 /* Process BTF of a function to produce high-level expectation of function
@@ -7161,6 +7162,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 				tags |= ARG_TAG_TRUSTED;
 			} else if (strcmp(tag, "nonnull") == 0) {
 				tags |= ARG_TAG_NONNULL;
+			} else if (strcmp(tag, "maybe_null") == 0) {
+				tags |= ARG_TAG_MAYBE_NULL;
 			} else {
 				bpf_log(log, "arg#%d has unsupported set of tags\n", i);
 				return -EOPNOTSUPP;
@@ -7210,12 +7213,19 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 				return kern_type_id;
 
 			sub->args[i].arg_type = ARG_PTR_TO_BTF_ID | PTR_TRUSTED;
+			if (tags & ARG_TAG_MAYBE_NULL)
+				sub->args[i].arg_type |= PTR_MAYBE_NULL;
 			sub->args[i].btf_id = kern_type_id;
 			continue;
 		}
 		if (is_global) { /* generic user data pointer */
 			u32 mem_size;
 
+			if (tags & ARG_TAG_MAYBE_NULL) {
+				bpf_log(log, "arg#%d has invalid combination of tags\n", i);
+				return -EINVAL;
+			}
+
 			t = btf_type_skip_modifiers(btf, t->type, NULL);
 			ref_t = btf_resolve_size(btf, t, &mem_size);
 			if (IS_ERR(ref_t)) {
-- 
2.34.1


