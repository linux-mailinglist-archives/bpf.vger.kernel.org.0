Return-Path: <bpf+bounces-13192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8547D5EDC
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 01:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3CB1C20D83
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 23:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2776C9CA45;
	Tue, 24 Oct 2023 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzJSROAF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6390A47371;
	Tue, 24 Oct 2023 23:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A768C433C7;
	Tue, 24 Oct 2023 23:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698191782;
	bh=tVTJbGWG8aqHGnh46375ypb8qFPMT93kQGQI0BXEANk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kzJSROAF4xYj2zirgRQJLem1ixKZGpJwrDnX+TMi2VAcZPz02MueXAN3v02pVMpsi
	 M347SL7173Z0nNqeo6DKXhr+q2Rk5OzdNg6SM2Mo526wWwvAsDLcxB/BkciOoiqAEE
	 KfoZF03s8xOdTY4D2REa600bNsHLeSsU/KY6FOw5xV5no85Bba9jrfgX+7GBXz96K9
	 RGzBiuz95QwuwzDtThImp/RIvguAiHoVmmby4OSLzVnF7F/HnEoOBn02ROa3jqJugY
	 sYrA64cxA4hbNIhFaBIdJYLenrvyc1qqnCt6EZxFmqlpqywDb7Mtk7A+QRFytCJzjY
	 kJK0axOe9wedw==
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
	Song Liu <song@kernel.org>
Subject: [PATCH v6 bpf-next 3/9] bpf: Introduce KF_ARG_PTR_TO_CONST_STR
Date: Tue, 24 Oct 2023 16:55:45 -0700
Message-Id: <20231024235551.2769174-4-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024235551.2769174-1-song@kernel.org>
References: <20231024235551.2769174-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to ARG_PTR_TO_CONST_STR for BPF helpers, KF_ARG_PTR_TO_CONST_STR
specifies kfunc args that point to const strings. Annotation "__const_str"
is used to specify kfunc arg of type KF_ARG_PTR_TO_CONST_STR. Also, add
documentation for the "__const_str" annotation.

bpf_get_file_xattr() will be the first kfunc that uses this type.

Signed-off-by: Song Liu <song@kernel.org>
---
 Documentation/bpf/kfuncs.rst | 24 ++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 19 +++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 0d2647fb358d..e696aca08b3a 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -137,6 +137,30 @@ Either way, the returned buffer is either NULL, or of size buffer_szk. Without t
 annotation, the verifier will reject the program if a null pointer is passed in with
 a nonzero size.
 
+2.2.5 __const_str Annotation
+----------------------------
+This annotation is used to indicate that the argument is a constant string.
+
+An example is given below::
+
+        __bpf_kfunc bpf_get_file_xattr(..., const char *name__const_str, ...)
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
index 238a8e08e781..a9c6e8212469 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10656,6 +10656,11 @@ static bool is_kfunc_arg_nullable(const struct btf *btf, const struct btf_param
 	return __kfunc_param_match_suffix(btf, arg, "__nullable");
 }
 
+static bool is_kfunc_arg_const_str(const struct btf *btf, const struct btf_param *arg)
+{
+	return __kfunc_param_match_suffix(btf, arg, "__const_str");
+}
+
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const struct btf_param *arg,
 					  const char *name)
@@ -10799,6 +10804,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_RB_ROOT,
 	KF_ARG_PTR_TO_RB_NODE,
 	KF_ARG_PTR_TO_NULL,
+	KF_ARG_PTR_TO_CONST_STR,
 };
 
 enum special_kfunc_type {
@@ -10943,6 +10949,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_rbtree_node(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_RB_NODE;
 
+	if (is_kfunc_arg_const_str(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_CONST_STR;
+
 	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
 		if (!btf_type_is_struct(ref_t)) {
 			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
@@ -11566,6 +11575,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_MEM_SIZE:
 		case KF_ARG_PTR_TO_CALLBACK:
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
+		case KF_ARG_PTR_TO_CONST_STR:
 			/* Trusted by default */
 			break;
 		default:
@@ -11837,6 +11847,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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


