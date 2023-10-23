Return-Path: <bpf+bounces-13064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 392037D42C4
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 00:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A741C20B5E
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 22:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E367D219F9;
	Mon, 23 Oct 2023 22:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKxNr0NL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABD7257D;
	Mon, 23 Oct 2023 22:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB158C433C8;
	Mon, 23 Oct 2023 22:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698100882;
	bh=0LBNy4jEmP3QOJLS/v9sSKJshgRUg6NsdZQVstUHGPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JKxNr0NLpgHcNIbe+370znzKvNChoC62E5bJoyvgUw48GHpUOhBMZdTBLfvUxL3lt
	 IC4j/X0t8MTUHFV7YIhnZh/Wkaq4R62NwV4KF0K0YjoS/SLiWqxIDUPj9ecFbi5yPY
	 6A3aU6c3zCUTCuPkBkiZLv/cZDJH09kTiTcoOGlrrEvjqFV8djX4cDF6C8obXzNRQg
	 Gtq6FF+fSX06ifNr75co+uKVCcMJKKr7Cxmqd75L7aWgBgaqqVMedE/OXY2eafsacC
	 CTC35/Xkwh1M43tGtDWRM4TZPvFj65IK39MjjTn9yy0uLSvgLnC/6b46k5lpDdoubY
	 8sK/C0VDLvHaA==
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
Subject: [PATCH v4 bpf-next 2/9] bpf: Factor out helper check_reg_const_str()
Date: Mon, 23 Oct 2023 15:40:53 -0700
Message-Id: <20231023224100.2573116-3-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023224100.2573116-1-song@kernel.org>
References: <20231023224100.2573116-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This helper will be used to check whether a kfunc arg points to const
string. Add a type check (PTR_TO_MAP_VALUE) in case the helper is
misused in the future.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/verifier.c | 85 +++++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 36 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e9bc5d4a25a1..6ce5f0fbad84 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8265,6 +8265,54 @@ static enum bpf_dynptr_type dynptr_get_type(struct bpf_verifier_env *env,
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
+	if (WARN_ON_ONCE(reg->type != PTR_TO_MAP_VALUE))
+		return -EINVAL;
+
+	if (!bpf_map_is_rdonly(map)) {
+		verbose(env, "R%d does not point to a readonly map'\n", regno);
+		return -EACCES;
+	}
+
+	if (!tnum_is_const(reg->var_off)) {
+		verbose(env, "R%d is not a constant address'\n", regno);
+			return -EACCES;
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
@@ -8509,44 +8557,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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


