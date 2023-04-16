Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863AD6E363C
	for <lists+bpf@lfdr.de>; Sun, 16 Apr 2023 10:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjDPItk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 16 Apr 2023 04:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjDPItj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 16 Apr 2023 04:49:39 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CB3106;
        Sun, 16 Apr 2023 01:49:38 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id qh25so12361541qvb.1;
        Sun, 16 Apr 2023 01:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681634977; x=1684226977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bf8/DhXyxhQVxCLkoC9tNfxIfJDkgAT+2/+mmZzl0Og=;
        b=ckLo63LLv3aC872kK+l7PHvn16dsLcSt5FzZ5LHtFhEpCHLQqJ8m0Yek7lWlrUxKlO
         yLtdQ5/dRJNL6KsOZNFfe2OszMrnOZXuJ9oWHdEYwLpZBu2k6oToEeLKeNeOLADLACkI
         VpsrTY2eIkj+kzu+UHzHt+SrY3jfMmPmgTBuwF1w/vteg62fy40tmEgVXqDf1QRjtXF7
         lPLlBX1yiiAtqIH8JlCIdWd20m3AMOauukbOSqPDGabLblpIKxuxoRsTd0Xs6vfrQcgN
         /qU+hbT/LPWfQBpqndxZCFjm80dVM8Q380rpfIQuZxlsdnyq7DkCMmljbbhbOHiXCya0
         zv8g==
X-Gm-Message-State: AAQBX9ej0JaJBNz1hviSb3IyCgft37sh7Ssad8Fu9jh8ASGb8i7rkcHH
        G11nYHQJm5zIyN9YrjvmZTSWX8hIkCkruQcE4YXDZg==
X-Google-Smtp-Source: AKy350YkDXYDeTE1tPQM4QuNTo3oOLWXHxs8/nddkF4/XRhDcd7uRJUgO2tBH7420HK5vj9e/zZb2g==
X-Received: by 2002:a05:6214:5090:b0:5ef:67b9:8d37 with SMTP id kk16-20020a056214509000b005ef67b98d37mr4173633qvb.13.1681634976964;
        Sun, 16 Apr 2023 01:49:36 -0700 (PDT)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id s14-20020ad44b2e000000b005eee5c22f30sm2298803qvw.139.2023.04.16.01.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 01:49:36 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, memxor@gmail.com
Subject: [PATCH bpf-next v2 1/3] bpf: Remove bpf_kfunc_call_test_kptr_get() test kfunc
Date:   Sun, 16 Apr 2023 03:49:26 -0500
Message-Id: <20230416084928.326135-2-void@manifault.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416084928.326135-1-void@manifault.com>
References: <20230416084928.326135-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We've managed to improve the UX for kptrs significantly over the last 9
months. All of the prior main use cases, struct bpf_cpumask *, struct
task_struct *, and struct cgroup *, have all been updated to be
synchronized mainly using RCU. In other words, their KF_ACQUIRE kfunc
calls are all KF_RCU, and the pointers themselves are MEM_RCU and can be
accessed in an RCU read region in BPF.

In a follow-on change, we'll be removing the KF_KPTR_GET kfunc flag.
This patch prepares for that by removing the
bpf_kfunc_call_test_kptr_get() kfunc, and all associated selftests.

Signed-off-by: David Vernet <void@manifault.com>
---
 net/bpf/test_run.c                            | 12 ---
 tools/testing/selftests/bpf/progs/map_kptr.c  | 40 ++--------
 .../selftests/bpf/progs/map_kptr_fail.c       | 78 -------------------
 .../testing/selftests/bpf/verifier/map_kptr.c | 27 -------
 4 files changed, 5 insertions(+), 152 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 0b9bd9b39990..f170e8a17974 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -679,17 +679,6 @@ __bpf_kfunc void bpf_kfunc_call_int_mem_release(int *p)
 {
 }
 
-__bpf_kfunc struct prog_test_ref_kfunc *
-bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **pp, int a, int b)
-{
-	struct prog_test_ref_kfunc *p = READ_ONCE(*pp);
-
-	if (!p)
-		return NULL;
-	refcount_inc(&p->cnt);
-	return p;
-}
-
 struct prog_test_pass1 {
 	int x0;
 	struct {
@@ -804,7 +793,6 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_get_rdwr_mem, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_get_rdonly_mem, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_acq_rdonly_mem, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_kfunc_call_int_mem_release, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_kptr_get, KF_ACQUIRE | KF_RET_NULL | KF_KPTR_GET)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass_ctx)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass2)
diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing/selftests/bpf/progs/map_kptr.c
index dae5dab1bbf7..d7150041e5d1 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr.c
@@ -115,8 +115,6 @@ DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_HASH_OF_MAPS, hash_malloc_map, hash_of_hash_mallo
 DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_HASH_OF_MAPS, lru_hash_map, hash_of_lru_hash_maps);
 
 extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
-extern struct prog_test_ref_kfunc *
-bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int b) __ksym;
 extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
 void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p) __ksym;
 
@@ -187,25 +185,10 @@ static void test_kptr_ref(struct map_value *v)
 	bpf_kfunc_call_test_release(p);
 }
 
-static void test_kptr_get(struct map_value *v)
-{
-	struct prog_test_ref_kfunc *p;
-
-	p = bpf_kfunc_call_test_kptr_get(&v->ref_ptr, 0, 0);
-	if (!p)
-		return;
-	if (p->a + p->b > 100) {
-		bpf_kfunc_call_test_release(p);
-		return;
-	}
-	bpf_kfunc_call_test_release(p);
-}
-
 static void test_kptr(struct map_value *v)
 {
 	test_kptr_unref(v);
 	test_kptr_ref(v);
-	test_kptr_get(v);
 }
 
 SEC("tc")
@@ -338,38 +321,25 @@ int test_map_kptr_ref_pre(struct map_value *v)
 	if (p_st->cnt.refs.counter != ref)
 		return 4;
 
-	p = bpf_kfunc_call_test_kptr_get(&v->ref_ptr, 0, 0);
-	if (!p)
-		return 5;
-	ref++;
-	if (p_st->cnt.refs.counter != ref) {
-		ret = 6;
-		goto end;
-	}
-	bpf_kfunc_call_test_release(p);
-	ref--;
-	if (p_st->cnt.refs.counter != ref)
-		return 7;
-
 	p = bpf_kptr_xchg(&v->ref_ptr, NULL);
 	if (!p)
-		return 8;
+		return 5;
 	bpf_kfunc_call_test_release(p);
 	ref--;
 	if (p_st->cnt.refs.counter != ref)
-		return 9;
+		return 6;
 
 	p = bpf_kfunc_call_test_acquire(&arg);
 	if (!p)
-		return 10;
+		return 7;
 	ref++;
 	p = bpf_kptr_xchg(&v->ref_ptr, p);
 	if (p) {
-		ret = 11;
+		ret = 8;
 		goto end;
 	}
 	if (p_st->cnt.refs.counter != ref)
-		return 12;
+		return 9;
 	/* Leave in map */
 
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
index 15bf3127dba3..da8c724f839b 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
@@ -21,8 +21,6 @@ struct array_map {
 
 extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
 extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
-extern struct prog_test_ref_kfunc *
-bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int b) __ksym;
 
 SEC("?tc")
 __failure __msg("kptr access size must be BPF_DW")
@@ -220,67 +218,6 @@ int reject_kptr_xchg_on_unref(struct __sk_buff *ctx)
 	return 0;
 }
 
-SEC("?tc")
-__failure __msg("arg#0 expected pointer to map value")
-int reject_kptr_get_no_map_val(struct __sk_buff *ctx)
-{
-	bpf_kfunc_call_test_kptr_get((void *)&ctx, 0, 0);
-	return 0;
-}
-
-SEC("?tc")
-__failure __msg("arg#0 expected pointer to map value")
-int reject_kptr_get_no_null_map_val(struct __sk_buff *ctx)
-{
-	bpf_kfunc_call_test_kptr_get(bpf_map_lookup_elem(&array_map, &(int){0}), 0, 0);
-	return 0;
-}
-
-SEC("?tc")
-__failure __msg("arg#0 no referenced kptr at map value offset=0")
-int reject_kptr_get_no_kptr(struct __sk_buff *ctx)
-{
-	struct map_value *v;
-	int key = 0;
-
-	v = bpf_map_lookup_elem(&array_map, &key);
-	if (!v)
-		return 0;
-
-	bpf_kfunc_call_test_kptr_get((void *)v, 0, 0);
-	return 0;
-}
-
-SEC("?tc")
-__failure __msg("arg#0 no referenced kptr at map value offset=8")
-int reject_kptr_get_on_unref(struct __sk_buff *ctx)
-{
-	struct map_value *v;
-	int key = 0;
-
-	v = bpf_map_lookup_elem(&array_map, &key);
-	if (!v)
-		return 0;
-
-	bpf_kfunc_call_test_kptr_get(&v->unref_ptr, 0, 0);
-	return 0;
-}
-
-SEC("?tc")
-__failure __msg("kernel function bpf_kfunc_call_test_kptr_get args#0")
-int reject_kptr_get_bad_type_match(struct __sk_buff *ctx)
-{
-	struct map_value *v;
-	int key = 0;
-
-	v = bpf_map_lookup_elem(&array_map, &key);
-	if (!v)
-		return 0;
-
-	bpf_kfunc_call_test_kptr_get((void *)&v->ref_memb_ptr, 0, 0);
-	return 0;
-}
-
 SEC("?tc")
 __failure __msg("R1 type=rcu_ptr_or_null_ expected=percpu_ptr_")
 int mark_ref_as_untrusted_or_null(struct __sk_buff *ctx)
@@ -428,21 +365,6 @@ int kptr_xchg_ref_state(struct __sk_buff *ctx)
 	return 0;
 }
 
-SEC("?tc")
-__failure __msg("Unreleased reference id=3 alloc_insn=")
-int kptr_get_ref_state(struct __sk_buff *ctx)
-{
-	struct map_value *v;
-	int key = 0;
-
-	v = bpf_map_lookup_elem(&array_map, &key);
-	if (!v)
-		return 0;
-
-	bpf_kfunc_call_test_kptr_get(&v->ref_ptr, 0, 0);
-	return 0;
-}
-
 SEC("?tc")
 __failure __msg("Possibly NULL pointer passed to helper arg2")
 int kptr_xchg_possibly_null(struct __sk_buff *ctx)
diff --git a/tools/testing/selftests/bpf/verifier/map_kptr.c b/tools/testing/selftests/bpf/verifier/map_kptr.c
index d775ccb01989..a0cfc06d75bc 100644
--- a/tools/testing/selftests/bpf/verifier/map_kptr.c
+++ b/tools/testing/selftests/bpf/verifier/map_kptr.c
@@ -288,33 +288,6 @@
 	.result = REJECT,
 	.errstr = "off=0 kptr isn't referenced kptr",
 },
-{
-	"map_kptr: unref: bpf_kfunc_call_test_kptr_get rejected",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_LD_MAP_FD(BPF_REG_6, 0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.fixup_map_kptr = { 1 },
-	.result = REJECT,
-	.errstr = "arg#0 no referenced kptr at map value offset=0",
-	.fixup_kfunc_btf_id = {
-		{ "bpf_kfunc_call_test_kptr_get", 13 },
-	}
-},
 /* Tests for referenced PTR_TO_BTF_ID */
 {
 	"map_kptr: ref: loaded pointer marked as untrusted",
-- 
2.40.0

