Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D57558AA7
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 23:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiFWVWo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 17:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiFWVWn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 17:22:43 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF654DF46
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 14:22:42 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id C5880240107
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 23:22:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656019360; bh=BWF5juSH4OFVP9/mF+9kB69sXZH7tp/Fku8ot8dr4DI=;
        h=From:To:Cc:Subject:Date:From;
        b=b5V5sSOVpqwosYV9fj/BO4LDXbeTkBfVSp59v8l7KvVitP1R3Puu1HJQNtcN+klU4
         1O3xXP1ohWKAFtICOwAkdCAyPsIOOpzSrz0SfPNzmYJ50s3DOY1MejcSh8ZcVxYTf2
         O/p1mRchh9ecqCgW5TfbpxP+AIKMzP8UJACE4hZ7zETLps2VxWdCVtjEitOoh8Ai6Z
         4JlMqIlYs+UNTNgni/QWd8jreY4JP55b8xIyWeQno987mEivgzHH8/GhWkSQdKnkiY
         LWl7HdZECLRXljycWYbPds3Voc+jC3v6oMVGekwxpD82HoUCq+MllhwZ9nXjbDMH5M
         bI3lgQ708JVFQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LTYB80wPvz6tmb;
        Thu, 23 Jun 2022 23:22:40 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     joannelkoong@gmail.com
Subject: [PATCH bpf-next v2 6/9] libbpf: Honor TYPE_MATCH relocation
Date:   Thu, 23 Jun 2022 21:22:02 +0000
Message-Id: <20220623212205.2805002-7-deso@posteo.net>
In-Reply-To: <20220623212205.2805002-1-deso@posteo.net>
References: <20220623212205.2805002-1-deso@posteo.net>
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

This patch finalizes support for the proposed type match relation in
libbpf by hooking it up to the TYPE_MATCH relocation. For this
relocation to be handled correctly by LLVM we have D126838
(https://reviews.llvm.org/D126838).
The main functionality is present behind the newly introduced
bpf_core_type_matches macro (similar to bpf_core_type_exists). This
macro can be used to check whether a local type has a "match" in a
target BTF.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/lib/bpf/bpf_core_read.h | 10 ++++++++++
 tools/lib/bpf/libbpf.c        |  6 ++++++
 tools/lib/bpf/relo_core.c     | 16 ++++++++++++----
 tools/lib/bpf/relo_core.h     |  2 ++
 4 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index 2308f49..496e6a 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -184,6 +184,16 @@ enum bpf_enum_value_kind {
 #define bpf_core_type_exists(type)					    \
 	__builtin_preserve_type_info(*(typeof(type) *)0, BPF_TYPE_EXISTS)
 
+/*
+ * Convenience macro to check that provided named type
+ * (struct/union/enum/typedef) "matches" that in a target kernel.
+ * Returns:
+ *    1, if the type matches in the target kernel's BTF;
+ *    0, if the type does not match any in the target kernel
+ */
+#define bpf_core_type_matches(type)					    \
+	__builtin_preserve_type_info(*(typeof(type) *)0, BPF_TYPE_MATCHES)
+
 /*
  * Convenience macro to get the byte size of a provided named type
  * (struct/union/enum/typedef) in a target kernel.
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 49e359c..fee15d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5805,6 +5805,12 @@ int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
 	}
 }
 
+int bpf_core_types_match(const struct btf *local_btf, __u32 local_id,
+			 const struct btf *targ_btf, __u32 targ_id)
+{
+	return __bpf_core_types_match(local_btf, local_id, targ_btf, targ_id, 32);
+}
+
 static size_t bpf_core_hash_fn(const void *key, void *ctx)
 {
 	return (size_t)key;
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index bc5b060..862185 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -95,6 +95,7 @@ static const char *core_relo_kind_str(enum bpf_core_relo_kind kind)
 	case BPF_CORE_TYPE_ID_LOCAL: return "local_type_id";
 	case BPF_CORE_TYPE_ID_TARGET: return "target_type_id";
 	case BPF_CORE_TYPE_EXISTS: return "type_exists";
+	case BPF_CORE_TYPE_MATCHES: return "type_matches";
 	case BPF_CORE_TYPE_SIZE: return "type_size";
 	case BPF_CORE_ENUMVAL_EXISTS: return "enumval_exists";
 	case BPF_CORE_ENUMVAL_VALUE: return "enumval_value";
@@ -123,6 +124,7 @@ static bool core_relo_is_type_based(enum bpf_core_relo_kind kind)
 	case BPF_CORE_TYPE_ID_LOCAL:
 	case BPF_CORE_TYPE_ID_TARGET:
 	case BPF_CORE_TYPE_EXISTS:
+	case BPF_CORE_TYPE_MATCHES:
 	case BPF_CORE_TYPE_SIZE:
 		return true;
 	default:
@@ -171,7 +173,7 @@ static bool core_relo_is_enumval_based(enum bpf_core_relo_kind kind)
  *   - field 'a' access (corresponds to '2' in low-level spec);
  *   - array element #3 access (corresponds to '3' in low-level spec).
  *
- * Type-based relocations (TYPE_EXISTS/TYPE_SIZE,
+ * Type-based relocations (TYPE_EXISTS/TYPE_MATCHES/TYPE_SIZE,
  * TYPE_ID_LOCAL/TYPE_ID_TARGET) don't capture any field information. Their
  * spec and raw_spec are kept empty.
  *
@@ -488,9 +490,14 @@ static int bpf_core_spec_match(struct bpf_core_spec *local_spec,
 	targ_spec->relo_kind = local_spec->relo_kind;
 
 	if (core_relo_is_type_based(local_spec->relo_kind)) {
-		return bpf_core_types_are_compat(local_spec->btf,
-						 local_spec->root_type_id,
-						 targ_btf, targ_id);
+		if (local_spec->relo_kind == BPF_CORE_TYPE_MATCHES)
+			return bpf_core_types_match(local_spec->btf,
+						    local_spec->root_type_id,
+						    targ_btf, targ_id);
+		else
+			return bpf_core_types_are_compat(local_spec->btf,
+							 local_spec->root_type_id,
+							 targ_btf, targ_id);
 	}
 
 	local_acc = &local_spec->spec[0];
@@ -739,6 +746,7 @@ static int bpf_core_calc_type_relo(const struct bpf_core_relo *relo,
 			*validate = false;
 		break;
 	case BPF_CORE_TYPE_EXISTS:
+	case BPF_CORE_TYPE_MATCHES:
 		*val = 1;
 		break;
 	case BPF_CORE_TYPE_SIZE:
diff --git a/tools/lib/bpf/relo_core.h b/tools/lib/bpf/relo_core.h
index 289c63..9230234 100644
--- a/tools/lib/bpf/relo_core.h
+++ b/tools/lib/bpf/relo_core.h
@@ -72,6 +72,8 @@ int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
 			      const struct btf *targ_btf, __u32 targ_id);
 int __bpf_core_types_match(const struct btf *local_btf, __u32 local_id, const struct btf *targ_btf,
 			   __u32 targ_id, int level);
+int bpf_core_types_match(const struct btf *local_btf, __u32 local_id, const struct btf *targ_btf,
+			 __u32 targ_id);
 
 size_t bpf_core_essential_name_len(const char *name);
 
-- 
2.30.2

