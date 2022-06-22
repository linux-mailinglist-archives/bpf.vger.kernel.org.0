Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E7155527D
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 19:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiFVRfW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 13:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiFVRfV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 13:35:21 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0D731DFD
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 10:35:20 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 4FE6D24010A
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 19:35:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1655919319; bh=vdPnGbTMhHQ5d+2pMwd2YPgXDrBAOs7QfWW7M8oNf/A=;
        h=From:To:Subject:Date:From;
        b=qwX/vYNgnJnBZida7hphuWANqFtsZx6+pDknmCe95YC0EO0MjDsRo2GxROThP/WCZ
         Ua+IGwFog1M4yVVM2UGuZQGNCSwkIrzJplqzmYZzWDxMSGorJqVBc/EzdL4tGnYm1v
         by7a7TPBjTvtCrATxG4lM9ocw4rIhgoOJMdGpeOjgRliBSyyGQQ0CdkvAsywL1A8bs
         5px3L1JJkoPpaRuVzRVrXZwVNs7Azr7axeCXVAjwbO/0kk6ePXIYQ1Z4HBpqhgU/tU
         5dnj7hIMZph5C0j5iTPgGIjgDfza0+/X2bUktjpvvOG46tvMOMGmNmn5HmdndRuyPE
         NVQOP34EMrH2Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LSrBG3k4Jz6tmy;
        Wed, 22 Jun 2022 19:35:18 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: [PATCH bpf-next 2/2] bpf: Use bpf_core_types_are_compat functionality from relo_core.c
Date:   Wed, 22 Jun 2022 17:35:06 +0000
Message-Id: <20220622173506.860578-3-deso@posteo.net>
In-Reply-To: <20220622173506.860578-1-deso@posteo.net>
References: <20220622173506.860578-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change adjusts the kernel BPF code to use
bpf_core_types_are_compat_recur() from relo_core.c for its
implementation of bpf_core_types_are_compat(). In so doing we fix an
oversight where we were still comparing local and target BTF kinds for
equality directly, as opposed to using btf_kind_core_compat() which
correctly handles enum/enum64 kinds.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 kernel/bpf/btf.c | 86 ++----------------------------------------------
 1 file changed, 2 insertions(+), 84 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f08037..031511b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7416,87 +7416,6 @@ EXPORT_SYMBOL_GPL(register_btf_id_dtor_kfuncs);
 
 #define MAX_TYPES_ARE_COMPAT_DEPTH 2
 
-static
-int __bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
-				const struct btf *targ_btf, __u32 targ_id,
-				int level)
-{
-	const struct btf_type *local_type, *targ_type;
-	int depth = 32; /* max recursion depth */
-
-	/* caller made sure that names match (ignoring flavor suffix) */
-	local_type = btf_type_by_id(local_btf, local_id);
-	targ_type = btf_type_by_id(targ_btf, targ_id);
-	if (btf_kind(local_type) != btf_kind(targ_type))
-		return 0;
-
-recur:
-	depth--;
-	if (depth < 0)
-		return -EINVAL;
-
-	local_type = btf_type_skip_modifiers(local_btf, local_id, &local_id);
-	targ_type = btf_type_skip_modifiers(targ_btf, targ_id, &targ_id);
-	if (!local_type || !targ_type)
-		return -EINVAL;
-
-	if (btf_kind(local_type) != btf_kind(targ_type))
-		return 0;
-
-	switch (btf_kind(local_type)) {
-	case BTF_KIND_UNKN:
-	case BTF_KIND_STRUCT:
-	case BTF_KIND_UNION:
-	case BTF_KIND_ENUM:
-	case BTF_KIND_FWD:
-	case BTF_KIND_ENUM64:
-		return 1;
-	case BTF_KIND_INT:
-		/* just reject deprecated bitfield-like integers; all other
-		 * integers are by default compatible between each other
-		 */
-		return btf_int_offset(local_type) == 0 && btf_int_offset(targ_type) == 0;
-	case BTF_KIND_PTR:
-		local_id = local_type->type;
-		targ_id = targ_type->type;
-		goto recur;
-	case BTF_KIND_ARRAY:
-		local_id = btf_array(local_type)->type;
-		targ_id = btf_array(targ_type)->type;
-		goto recur;
-	case BTF_KIND_FUNC_PROTO: {
-		struct btf_param *local_p = btf_params(local_type);
-		struct btf_param *targ_p = btf_params(targ_type);
-		__u16 local_vlen = btf_vlen(local_type);
-		__u16 targ_vlen = btf_vlen(targ_type);
-		int i, err;
-
-		if (local_vlen != targ_vlen)
-			return 0;
-
-		for (i = 0; i < local_vlen; i++, local_p++, targ_p++) {
-			if (level <= 0)
-				return -EINVAL;
-
-			btf_type_skip_modifiers(local_btf, local_p->type, &local_id);
-			btf_type_skip_modifiers(targ_btf, targ_p->type, &targ_id);
-			err = __bpf_core_types_are_compat(local_btf, local_id,
-							  targ_btf, targ_id,
-							  level - 1);
-			if (err <= 0)
-				return err;
-		}
-
-		/* tail recurse for return type check */
-		btf_type_skip_modifiers(local_btf, local_type->type, &local_id);
-		btf_type_skip_modifiers(targ_btf, targ_type->type, &targ_id);
-		goto recur;
-	}
-	default:
-		return 0;
-	}
-}
-
 /* Check local and target types for compatibility. This check is used for
  * type-based CO-RE relocations and follow slightly different rules than
  * field-based relocations. This function assumes that root types were already
@@ -7519,9 +7438,8 @@ int __bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
 int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
 			      const struct btf *targ_btf, __u32 targ_id)
 {
-	return __bpf_core_types_are_compat(local_btf, local_id,
-					   targ_btf, targ_id,
-					   MAX_TYPES_ARE_COMPAT_DEPTH);
+	return bpf_core_types_are_compat_recur(local_btf, local_id, targ_btf, targ_id,
+					       MAX_TYPES_ARE_COMPAT_DEPTH);
 }
 
 static bool bpf_core_is_flavor_sep(const char *s)
-- 
2.30.2

