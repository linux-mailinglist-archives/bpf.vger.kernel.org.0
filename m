Return-Path: <bpf+bounces-14163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2887E0BBB
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 00:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E957B21521
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F9C24A1C;
	Fri,  3 Nov 2023 23:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDZ9WRou"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EFA2374F;
	Fri,  3 Nov 2023 23:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10FDC433C9;
	Fri,  3 Nov 2023 23:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699052568;
	bh=hgbaitJNg/zbrBgRc56X5hcBLRwdZPPPxXNcGWECEcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vDZ9WRou+a3sGAg96YxABb9gBWua1lvrQX7MBwoxJg1yGqOOZ0yKe2LeZbAehBkMm
	 mFtkaMHx0jKVC4iPI+RS4hb4iMzr93agTJNMEjP4o/5s1d5B7oM3vljVVS5PeLzj9Z
	 Z52fUTh1fjUfJgmy1yKmGqCHMrE6aOpzZ4aFRRL0HrnfmC+rXUus5jQN5F9TrgsNcY
	 TrFf3Hu8m+csz8VxOw/fpOuNp9PG5j2EhaO+TEQ4uT+dCxuX6cCz2BDnXp6COTifb1
	 GF6C5XIxHXEEgJENPYf9vQaKpsuPo0LYIl+VctIfgnUsbICr3ijcxo4vhgR7lFPSY1
	 1W/QTKOAAeD6Q==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	kernel-team@meta.com,
	ebiggers@kernel.org,
	tytso@mit.edu,
	roberto.sassu@huaweicloud.com,
	kpsingh@kernel.org,
	vadfed@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v11 bpf-next 3/9] bpf: Introduce KF_ARG_PTR_TO_CONST_STR
Date: Fri,  3 Nov 2023 16:01:58 -0700
Message-Id: <20231103230204.3137000-4-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103230204.3137000-1-song@kernel.org>
References: <20231103230204.3137000-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to ARG_PTR_TO_CONST_STR for BPF helpers, KF_ARG_PTR_TO_CONST_STR
specifies kfunc args that point to const strings. Annotation "__str" is
used to specify kfunc arg of type KF_ARG_PTR_TO_CONST_STR. Also, add
documentation for the "__str" annotation.

bpf_get_file_xattr() will be the first kfunc that uses this type.

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 Documentation/bpf/kfuncs.rst | 24 ++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 19 +++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 0d2647fb358d..bfe065f7e23c 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -137,6 +137,30 @@ Either way, the returned buffer is either NULL, or of size buffer_szk. Without t
 annotation, the verifier will reject the program if a null pointer is passed in with
 a nonzero size.
 
+2.2.5 __str Annotation
+----------------------------
+This annotation is used to indicate that the argument is a constant string.
+
+An example is given below::
+
+        __bpf_kfunc bpf_get_file_xattr(..., const char *name__str, ...)
+        {
+        ...
+        }
+
+In this case, ``bpf_get_file_xattr()`` can be called as::
+
+        bpf_get_file_xattr(..., "xattr_name", ...);
+
+Or::
+
+        const char name[] = "xattr_name";  /* This need to be global */
+        int BPF_PROG(...)
+        {
+                ...
+                bpf_get_file_xattr(..., name, ...);
+                ...
+        }
 
 .. _BPF_kfunc_nodef:
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 618446006d5a..bf94ba50c6ee 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10803,6 +10803,11 @@ static bool is_kfunc_arg_nullable(const struct btf *btf, const struct btf_param
 	return __kfunc_param_match_suffix(btf, arg, "__nullable");
 }
 
+static bool is_kfunc_arg_const_str(const struct btf *btf, const struct btf_param *arg)
+{
+	return __kfunc_param_match_suffix(btf, arg, "__str");
+}
+
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const struct btf_param *arg,
 					  const char *name)
@@ -10946,6 +10951,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_RB_ROOT,
 	KF_ARG_PTR_TO_RB_NODE,
 	KF_ARG_PTR_TO_NULL,
+	KF_ARG_PTR_TO_CONST_STR,
 };
 
 enum special_kfunc_type {
@@ -11090,6 +11096,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_rbtree_node(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_RB_NODE;
 
+	if (is_kfunc_arg_const_str(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_CONST_STR;
+
 	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
 		if (!btf_type_is_struct(ref_t)) {
 			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
@@ -11713,6 +11722,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_MEM_SIZE:
 		case KF_ARG_PTR_TO_CALLBACK:
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
+		case KF_ARG_PTR_TO_CONST_STR:
 			/* Trusted by default */
 			break;
 		default:
@@ -11984,6 +11994,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			meta->arg_btf = reg->btf;
 			meta->arg_btf_id = reg->btf_id;
 			break;
+		case KF_ARG_PTR_TO_CONST_STR:
+			if (reg->type != PTR_TO_MAP_VALUE) {
+				verbose(env, "arg#%d doesn't point to a const string\n", i);
+				return -EINVAL;
+			}
+			ret = check_reg_const_str(env, reg, regno);
+			if (ret)
+				return ret;
+			break;
 		}
 	}
 
-- 
2.34.1


