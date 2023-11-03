Return-Path: <bpf+bounces-14162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA4C7E0BBA
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 00:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5CB5B214CE
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0760924A18;
	Fri,  3 Nov 2023 23:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taBZYZpj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699532374F;
	Fri,  3 Nov 2023 23:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBB7C433C7;
	Fri,  3 Nov 2023 23:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699052562;
	bh=OM4WR9ps6R5J3zVAbPqM2x/p9rlr8xLxqQT66TFfm+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=taBZYZpjle7aLZWU00IGOfQKtOLHkki3lmN6ynNTJnaDDwH6qLjl91b9Ynjx5UnG3
	 5ODggW5UhStpiCnMkd6IXpPEaB6FXE0L2fijPx3C9zCnVUf3tkSLdAeW+UFbILVH0M
	 KiVJkY3gga3dwcJSyb+4J1W+y5kM/PJ5qG2wv2N1zFzhvtlYTji5BptVLlbjDVECTW
	 03dV9KrvU4ibVAdpvQT5ShvjsN+WRy2HPoCq/+xmYWfXdoyzfRFrAaeygmS1k/VFqe
	 B3+LEpXFfOBEL2RfDD1i5UQd9uApJdb9vge2wgQlVkJpuQmGQXV3zWvDlZ7y+w5kYx
	 lyV7WczbROtrw==
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
Subject: [PATCH v11 bpf-next 2/9] bpf: Factor out helper check_reg_const_str()
Date: Fri,  3 Nov 2023 16:01:57 -0700
Message-Id: <20231103230204.3137000-3-song@kernel.org>
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

ARG_PTR_TO_CONST_STR is used to specify constant string args for BPF
helpers. The logic that verifies a reg is ARG_PTR_TO_CONST_STR is
implemented in check_func_arg().

As we introduce kfuncs with constant string args, it is necessary to
do the same check for kfuncs (in check_kfunc_args). Factor out the logic
for ARG_PTR_TO_CONST_STR to a new check_reg_const_str() so that it can be
reused.

check_func_arg() ensures check_reg_const_str() is only called with reg of
type PTR_TO_MAP_VALUE. Add a redundent type check in check_reg_const_str()
to avoid misuse in the future. Other than this redundent check, there is
no change in behavior.

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 85 +++++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 36 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2197385d91dc..618446006d5a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8718,6 +8718,54 @@ static enum bpf_dynptr_type dynptr_get_type(struct bpf_verifier_env *env,
 	return state->stack[spi].spilled_ptr.dynptr.type;
 }
 
+static int check_reg_const_str(struct bpf_verifier_env *env,
+			       struct bpf_reg_state *reg, u32 regno)
+{
+	struct bpf_map *map = reg->map_ptr;
+	int err;
+	int map_off;
+	u64 map_addr;
+	char *str_ptr;
+
+	if (reg->type != PTR_TO_MAP_VALUE)
+		return -EINVAL;
+
+	if (!bpf_map_is_rdonly(map)) {
+		verbose(env, "R%d does not point to a readonly map'\n", regno);
+		return -EACCES;
+	}
+
+	if (!tnum_is_const(reg->var_off)) {
+		verbose(env, "R%d is not a constant address'\n", regno);
+		return -EACCES;
+	}
+
+	if (!map->ops->map_direct_value_addr) {
+		verbose(env, "no direct value access support for this map type\n");
+		return -EACCES;
+	}
+
+	err = check_map_access(env, regno, reg->off,
+			       map->value_size - reg->off, false,
+			       ACCESS_HELPER);
+	if (err)
+		return err;
+
+	map_off = reg->off + reg->var_off.value;
+	err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
+	if (err) {
+		verbose(env, "direct value access on string failed\n");
+		return err;
+	}
+
+	str_ptr = (char *)(long)(map_addr);
+	if (!strnchr(str_ptr + map_off, map->value_size - map_off, 0)) {
+		verbose(env, "string is not zero-terminated\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  const struct bpf_func_proto *fn,
@@ -8962,44 +9010,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	}
 	case ARG_PTR_TO_CONST_STR:
 	{
-		struct bpf_map *map = reg->map_ptr;
-		int map_off;
-		u64 map_addr;
-		char *str_ptr;
-
-		if (!bpf_map_is_rdonly(map)) {
-			verbose(env, "R%d does not point to a readonly map'\n", regno);
-			return -EACCES;
-		}
-
-		if (!tnum_is_const(reg->var_off)) {
-			verbose(env, "R%d is not a constant address'\n", regno);
-			return -EACCES;
-		}
-
-		if (!map->ops->map_direct_value_addr) {
-			verbose(env, "no direct value access support for this map type\n");
-			return -EACCES;
-		}
-
-		err = check_map_access(env, regno, reg->off,
-				       map->value_size - reg->off, false,
-				       ACCESS_HELPER);
+		err = check_reg_const_str(env, reg, regno);
 		if (err)
 			return err;
-
-		map_off = reg->off + reg->var_off.value;
-		err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
-		if (err) {
-			verbose(env, "direct value access on string failed\n");
-			return err;
-		}
-
-		str_ptr = (char *)(long)(map_addr);
-		if (!strnchr(str_ptr + map_off, map->value_size - map_off, 0)) {
-			verbose(env, "string is not zero-terminated\n");
-			return -EINVAL;
-		}
 		break;
 	}
 	case ARG_PTR_TO_KPTR:
-- 
2.34.1


