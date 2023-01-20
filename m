Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03AC675DEC
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 20:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjATTZd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 14:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjATTZb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 14:25:31 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA11A500B;
        Fri, 20 Jan 2023 11:25:27 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id q15so4988735qtn.0;
        Fri, 20 Jan 2023 11:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+W32fWb/CNB6qimyvYrdya9osCOV2Z+fu3ZyPaW8RI=;
        b=k63L2Czt5BAIm2x/a7QL/3M5Vsl6w8CmdtNDrZjcJtIkYxJ9fbdaxaR3iZIRWezWL/
         hwkkoWi2P1ABDuYWEtJPlTeR9iMG661EIJmusjHpwqSynm68dlaKbtDI6bR2DbHdB7CV
         NHeDPX4uHNxpjp45tYjIhrAHfcHKEbXZsnzkU6TQyaYANeSLReRxHBmPZKek8jR9ldaB
         5HE4LnJaVDQKsiMAZnWqEZa1eqhefoO+TOdPe29cy4vzw94aGj7mF9YChT+H1be2oonf
         pED7TLpVK/Q6oEDQC057ISjkN8ZjsDl2fO7J+PlW2E8JLXHtxyCjFHixmkjYoEb+ildj
         QzoA==
X-Gm-Message-State: AFqh2kpnm4lL/WW2+pXUk6tF0sVWKbyBAK3oNXzNpa5fFcNskEDw82+Y
        VZ2WD2uS0FlT4op2Dx6muZnTVzjFMreewHFo
X-Google-Smtp-Source: AMrXdXsBlBbZ+ecsIP5CPVgqVL3ncr9ymNrHaQDCd1AV09ZfpwPWcYA9UeLza3smODKHcYFvwh/Xqw==
X-Received: by 2002:ac8:478c:0:b0:3a8:10c4:4ae with SMTP id k12-20020ac8478c000000b003a810c404aemr21483241qtq.49.1674242726341;
        Fri, 20 Jan 2023 11:25:26 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id s18-20020a05620a255200b006eeb3165565sm26793423qko.80.2023.01.20.11.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:25:25 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH bpf-next v2 2/9] bpf: Allow trusted args to walk struct when checking BTF IDs
Date:   Fri, 20 Jan 2023 13:25:16 -0600
Message-Id: <20230120192523.3650503-3-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120192523.3650503-1-void@manifault.com>
References: <20230120192523.3650503-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When validating BTF types for KF_TRUSTED_ARGS kfuncs, the verifier
currently enforces that the top-level type must match when calling
the kfunc. In other words, the verifier does not allow the BPF program
to pass a bitwise equivalent struct, despite it being allowed according
to the C standard.

For example, if you have the following type:

struct  nf_conn___init {
	struct nf_conn ct;
};

The C standard stipulates that it would be safe to pass a struct
nf_conn___init to a kfunc expecting a struct nf_conn. The verifier
currently disallows this, however, as semantically kfuncs may want to
enforce that structs that have equivalent types according to the C
standard, but have different BTF IDs, are not able to be passed to
kfuncs expecting one or the other. For example, struct nf_conn___init
may not be queried / looked up, as it is allocated but may not yet be
fully initialized.

On the other hand, being able to pass types that are equivalent
according to the C standard will be useful for other types of kfunc /
kptrs enabled by BPF.  For example, in a follow-on patch, a series of
kfuncs will be added which allow programs to do bitwise queries on
cpumasks that are either allocated by the program (in which case they'll
be a 'struct bpf_cpumask' type that wraps a cpumask_t as its first
element), or a cpumask that was allocated by the main kernel (in which
case it will just be a straight cpumask_t, as in task->cpus_ptr).

Having the two types of cpumasks allows us to distinguish between the
two for when a cpumask is read-only vs. mutatable. A struct bpf_cpumask
can be mutated by e.g. bpf_cpumask_clear(), whereas a regular cpumask_t
cannot be. On the other hand, a struct bpf_cpumask can of course be
queried in the exact same manner as a cpumask_t, with e.g.
bpf_cpumask_test_cpu().

If we were to enforce that top level types match, then a user that's
passing a struct bpf_cpumask to a read-only cpumask_t argument would
have to cast with something like bpf_cast_to_kern_ctx() (which itself
would need to be updated to expect the alias, and currently it only
accommodates a single alias per prog type). Additionally, not specifying
KF_TRUSTED_ARGS is not an option, as some kfuncs take one argument as a
struct bpf_cpumask *, and another as a struct cpumask *
(i.e. cpumask_t).

In order to enable this, this patch relaxes the constraint that a
KF_TRUSTED_ARGS kfunc must have strict type matching, and instead only
enforces strict type matching if a type is observed to be a "no-cast
alias" (i.e., that the type names are equivalent, but one is suffixed
with ___init).

Additionally, in order to try and be conservative and match existing
behavior / expectations, this patch also enforces strict type checking
for acquire kfuncs. We were already enforcing it for release kfuncs, so
this should also improve the consistency of the semantics for kfuncs.

Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/bpf.h   |  4 +++
 kernel/bpf/btf.c      | 61 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 30 ++++++++++++++++++++-
 3 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 283e96e5b228..d01d99127b7b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2190,6 +2190,10 @@ bool btf_nested_type_is_trusted(struct bpf_verifier_log *log,
 				const struct bpf_reg_state *reg,
 				int off);
 
+bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
+			       const struct btf *reg_btf, u32 reg_id,
+			       const struct btf *arg_btf, u32 arg_id);
+
 int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 		   int relo_idx, void *insn);
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index dd05b5f2c1d8..47b8cb96f2c2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -336,6 +336,12 @@ const char *btf_type_str(const struct btf_type *t)
 /* Type name size */
 #define BTF_SHOW_NAME_SIZE		80
 
+/*
+ * The suffix of a type that indicates it cannot alias another type when
+ * comparing BTF IDs for kfunc invocations.
+ */
+#define NOCAST_ALIAS_SUFFIX		"___init"
+
 /*
  * Common data to all BTF show operations. Private show functions can add
  * their own data to a structure containing a struct btf_show and consult it
@@ -8288,3 +8294,58 @@ bool btf_nested_type_is_trusted(struct bpf_verifier_log *log,
 
 	return false;
 }
+
+bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
+			       const struct btf *reg_btf, u32 reg_id,
+			       const struct btf *arg_btf, u32 arg_id)
+{
+	const char *reg_name, *arg_name, *search_needle;
+	const struct btf_type *reg_type, *arg_type;
+	int reg_len, arg_len, cmp_len;
+	size_t pattern_len = sizeof(NOCAST_ALIAS_SUFFIX) - sizeof(char);
+
+	reg_type = btf_type_by_id(reg_btf, reg_id);
+	if (!reg_type)
+		return false;
+
+	arg_type = btf_type_by_id(arg_btf, arg_id);
+	if (!arg_type)
+		return false;
+
+	reg_name = btf_name_by_offset(reg_btf, reg_type->name_off);
+	arg_name = btf_name_by_offset(arg_btf, arg_type->name_off);
+
+	reg_len = strlen(reg_name);
+	arg_len = strlen(arg_name);
+
+	/* Exactly one of the two type names may be suffixed with ___init, so
+	 * if the strings are the same size, they can't possibly be no-cast
+	 * aliases of one another. If you have two of the same type names, e.g.
+	 * they're both nf_conn___init, it would be improper to return true
+	 * because they are _not_ no-cast aliases, they are the same type.
+	 */
+	if (reg_len == arg_len)
+		return false;
+
+	/* Either of the two names must be the other name, suffixed with ___init. */
+	if ((reg_len != arg_len + pattern_len) &&
+	    (arg_len != reg_len + pattern_len))
+		return false;
+
+	if (reg_len < arg_len) {
+		search_needle = strstr(arg_name, NOCAST_ALIAS_SUFFIX);
+		cmp_len = reg_len;
+	} else {
+		search_needle = strstr(reg_name, NOCAST_ALIAS_SUFFIX);
+		cmp_len = arg_len;
+	}
+
+	if (!search_needle)
+		return false;
+
+	/* ___init suffix must come at the end of the name */
+	if (*(search_needle + pattern_len) != '\0')
+		return false;
+
+	return !strncmp(reg_name, arg_name, cmp_len);
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7f973847b58e..ca5d601fb3cf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8563,9 +8563,37 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 		reg_ref_id = *reg2btf_ids[base_type(reg->type)];
 	}
 
-	if (is_kfunc_trusted_args(meta) || (is_kfunc_release(meta) && reg->ref_obj_id))
+	/* Enforce strict type matching for calls to kfuncs that are acquiring
+	 * or releasing a reference, or are no-cast aliases. We do _not_
+	 * enforce strict matching for plain KF_TRUSTED_ARGS kfuncs by default,
+	 * as we want to enable BPF programs to pass types that are bitwise
+	 * equivalent without forcing them to explicitly cast with something
+	 * like bpf_cast_to_kern_ctx().
+	 *
+	 * For example, say we had a type like the following:
+	 *
+	 * struct bpf_cpumask {
+	 *	cpumask_t cpumask;
+	 *	refcount_t usage;
+	 * };
+	 *
+	 * Note that as specified in <linux/cpumask.h>, cpumask_t is typedef'ed
+	 * to a struct cpumask, so it would be safe to pass a struct
+	 * bpf_cpumask * to a kfunc expecting a struct cpumask *.
+	 *
+	 * The philosophy here is similar to how we allow scalars of different
+	 * types to be passed to kfuncs as long as the size is the same. The
+	 * only difference here is that we're simply allowing
+	 * btf_struct_ids_match() to walk the struct at the 0th offset, and
+	 * resolve types.
+	 */
+	if (is_kfunc_acquire(meta) ||
+	    (is_kfunc_release(meta) && reg->ref_obj_id) ||
+	    btf_type_ids_nocast_alias(&env->log, reg_btf, reg_ref_id, meta->btf, ref_id))
 		strict_type_match = true;
 
+	WARN_ON_ONCE(is_kfunc_trusted_args(meta) && reg->off);
+
 	reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id, &reg_ref_id);
 	reg_ref_tname = btf_name_by_offset(reg_btf, reg_ref_t->name_off);
 	if (!btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->off, meta->btf, ref_id, strict_type_match)) {
-- 
2.39.0

