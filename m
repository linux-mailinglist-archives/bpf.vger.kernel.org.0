Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DAB6747AE
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 00:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjASX7J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 18:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjASX7H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 18:59:07 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C39A1992;
        Thu, 19 Jan 2023 15:58:38 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id d16so2968165qtw.8;
        Thu, 19 Jan 2023 15:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2QDBg/1laiFeLH6My9GT6cVr8OSt4tRqfsVWOsCqSc=;
        b=LUpP/q79MzeJ6l/5jSCEUgb9LskaSnUCGNZ6epBbOSMgh5o3VSSs52DOjMDZ/G5ryb
         5hQ/FE2g/n0TiiFvEa39D/LqaNBs24jvnpiBmEHYc3e3jWltLgM14M8QEIJxXTqFWToF
         xeY2So4RHF1FA+N0ib6kQHodP1UvAF22XVqi50/ejWhCj37Bq/fm+J4XXD5Ep+PcLmle
         Qh/HQkm8MqASBwDsiCkfhBYHM4MxXRINFHp7TjarXTIc9JkZ9/COB99fGXT/qjFG/xJ+
         XJ3JgnJMfr6wlJ0WV3t+vIJbVnWFVKftNtzMJc3IESFgzvrxuME6clvIgr41k9xNj57j
         a3Dg==
X-Gm-Message-State: AFqh2kob7v2I6UBfysXIprnk0521q86Rx0Lz/j+D58Vdvq0SnZKvWFhk
        Qs3MgT9e+Yd8J92SW1rs+ofq5+ugQEGkx11x
X-Google-Smtp-Source: AMrXdXv/eBA5GBDOYOkB8VhyJjRuNknYDiOjzBbwCWt3aYl5WrP2fpowIThGHdE15dt+qgtwWUeNSQ==
X-Received: by 2002:a05:622a:5d9a:b0:3b6:3494:175 with SMTP id fu26-20020a05622a5d9a00b003b634940175mr18779000qtb.66.1674172716672;
        Thu, 19 Jan 2023 15:58:36 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a408800b006b5cc25535fsm25744987qko.99.2023.01.19.15.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:58:36 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next 2/8] bpf: Allow trusted args to walk struct when checking BTF IDs
Date:   Thu, 19 Jan 2023 17:58:27 -0600
Message-Id: <20230119235833.2948341-3-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119235833.2948341-1-void@manifault.com>
References: <20230119235833.2948341-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When validating BTF types for KF_TRUSTED_ARGS kfuncs, the verifier
currently enforces that the top-level type must match when calling
the kfunc. In other words, the verifier does not allow the BPF program
to pass a bitwise equivalent struct, despite it being functionally safe.
For example, if you have the following type:

struct  nf_conn___init {
	struct nf_conn ct;
};

It would be safe to pass a struct nf_conn___init to a kfunc expecting a
struct nf_conn. Being able to do this will be useful for certain types
of kfunc / kptrs enabled by BPF. For example, in a follow-on patch, a
series of kfuncs will be added which allow programs to do bitwise
queries on cpumasks that are either allocated by the program (in which
case they'll be a 'struct bpf_cpumask' type that wraps a cpumask_t as
its first element), or a cpumask that was allocated by the main kernel
(in which case it will just be a straight cpumask_t, as in
 task->cpus_ptr).

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
KF_TRUSTED_ARGS kfunc must have strict type matching. In order to
try and be conservative and match existing behavior / expectations, this
patch also enforces strict type checking for acquire kfuncs. We were
already enforcing it for release kfuncs, so this should also improve the
consistency of the semantics for kfuncs.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/verifier.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7f973847b58e..9fa101420046 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8563,9 +8563,34 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 		reg_ref_id = *reg2btf_ids[base_type(reg->type)];
 	}
 
-	if (is_kfunc_trusted_args(meta) || (is_kfunc_release(meta) && reg->ref_obj_id))
+	/* Enforce strict type matching for calls to kfuncs that are acquiring
+	 * or releasing a reference. We do _not_ enforce strict matching for
+	 * plain KF_TRUSTED_ARGS kfuncs, as we want to enable BPF programs to
+	 * pass types that are bitwise equivalent without forcing them to
+	 * explicitly cast with something like bpf_cast_to_kern_ctx().
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
+	if (is_kfunc_acquire(meta) || (is_kfunc_release(meta) && reg->ref_obj_id))
 		strict_type_match = true;
 
+	WARN_ON_ONCE(is_kfunc_trusted_args(meta) && reg->off);
+
 	reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id, &reg_ref_id);
 	reg_ref_tname = btf_name_by_offset(reg_btf, reg_ref_t->name_off);
 	if (!btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->off, meta->btf, ref_id, strict_type_match)) {
-- 
2.39.0

