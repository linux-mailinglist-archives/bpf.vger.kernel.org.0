Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BEC553BC7
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 22:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352430AbiFUUq4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 16:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353351AbiFUUqy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 16:46:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E731A23BC4
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 13:46:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3298B81B22
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 20:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10657C341C6;
        Tue, 21 Jun 2022 20:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655844411;
        bh=b1YeOq+ZBW326gTSk4aSA666NsJVmpTBYO7ZUTRYLcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oP3P/NNuVNs0tvrSKDf2ZOvvQpTNtxp0OLzDUNHcRjG7X/tnIuA+bRhkQCHEJ+Yt7
         Y7abCP9LghYCnw8EU7Q/E9X12zdQJQMf5/VLzu3jL0qV10H/yDQBtfUm7DEk+rRhyo
         0KCpT/h5nlJNXJAwYn9a6pxHOQOzeO+IebvF3kH2cRW4FJIRrNfqY98B31p4FJRklb
         21/kNxrklOkNk+5lpAV+L1ZmL3T/UoSAGspIzT7qpwMtyqy3G2XMX7W6OWoNID/fkG
         d81KkquwAs8d0IDFaUdVmrumKupg056fIcGgmU48pZC5axzDrEjV9h2QhiNdWQiJck
         rtvbPXeQ8YmjA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v3 bpf-next 2/5] bpf: kfunc support for ARG_PTR_TO_CONST_STR
Date:   Tue, 21 Jun 2022 20:46:39 +0000
Message-Id: <20220621204642.2891979-3-kpsingh@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220621204642.2891979-1-kpsingh@kernel.org>
References: <20220621204642.2891979-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

kfuncs can handle pointers to memory when the next argument is
the size of the memory that can be read and verify these as
ARG_CONST_SIZE_OR_ZERO

Similarly add support for string constants (const char *) and
verify it similar to ARG_PTR_TO_CONST_STR.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/bpf_verifier.h |  2 +
 kernel/bpf/btf.c             | 26 +++++++++++
 kernel/bpf/verifier.c        | 89 +++++++++++++++++++++---------------
 3 files changed, 79 insertions(+), 38 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3930c963fa67..60d490354397 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -548,6 +548,8 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
 			     u32 regno);
 int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		   u32 regno, u32 mem_size);
+int check_const_str(struct bpf_verifier_env *env,
+		    const struct bpf_reg_state *reg, int regno);
 
 /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
 static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 668ecf61649b..6608e8a0c5ca 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6162,6 +6162,23 @@ static bool is_kfunc_arg_mem_size(const struct btf *btf,
 	return true;
 }
 
+static bool btf_param_is_const_str_ptr(const struct btf *btf,
+				       const struct btf_param *param)
+{
+	const struct btf_type *t;
+
+	t = btf_type_by_id(btf, param->type);
+	if (!btf_type_is_ptr(t))
+		return false;
+
+	t = btf_type_by_id(btf, t->type);
+	if (!(BTF_INFO_KIND(t->info) == BTF_KIND_CONST))
+		return false;
+
+	t = btf_type_skip_modifiers(btf, t->type, NULL);
+	return !strcmp(btf_name_by_offset(btf, t->name_off), "char");
+}
+
 static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				    const struct btf *btf, u32 func_id,
 				    struct bpf_reg_state *regs,
@@ -6344,6 +6361,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 		} else if (ptr_to_mem_ok) {
 			const struct btf_type *resolve_ret;
 			u32 type_size;
+			int err;
 
 			if (is_kfunc) {
 				bool arg_mem_size = i + 1 < nargs && is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
@@ -6354,6 +6372,14 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				 * When arg_mem_size is true, the pointer can be
 				 * void *.
 				 */
+				if (btf_param_is_const_str_ptr(btf, &args[i])) {
+					err = check_const_str(env, reg, regno);
+					if (err < 0)
+						return err;
+					i++;
+					continue;
+				}
+
 				if (!btf_type_is_scalar(ref_t) &&
 				    !__btf_type_is_scalar_struct(log, btf, ref_t, 0) &&
 				    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2859901ffbe3..7ac501122df0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5840,6 +5840,56 @@ static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_reg_state
 	return state->stack[spi].spilled_ptr.id;
 }
 
+int check_const_str(struct bpf_verifier_env *env,
+		    const struct bpf_reg_state *reg, int regno)
+{
+	struct bpf_map *map;
+	int map_off;
+	u64 map_addr;
+	char *str_ptr;
+	int err;
+
+	if (reg->type != PTR_TO_MAP_VALUE)
+		return -EACCES;
+
+	map = reg->map_ptr;
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
+		verbose(env,
+			"no direct value access support for this map type\n");
+		return -EACCES;
+	}
+
+	err = check_map_access(env, regno, reg->off, map->value_size - reg->off,
+			       false, ACCESS_HELPER);
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
+
+	return 0;
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  const struct bpf_func_proto *fn)
@@ -6074,44 +6124,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return err;
 		err = check_ptr_alignment(env, reg, 0, size, true);
 	} else if (arg_type == ARG_PTR_TO_CONST_STR) {
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
-		if (err)
-			return err;
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
+		err = check_const_str(env, reg, regno);
 	} else if (arg_type == ARG_PTR_TO_KPTR) {
 		if (process_kptr_func(env, regno, meta))
 			return -EACCES;
-- 
2.37.0.rc0.104.g0611611a94-goog

