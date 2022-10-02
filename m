Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DDD5F2434
	for <lists+bpf@lfdr.de>; Sun,  2 Oct 2022 19:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJBRKN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Oct 2022 13:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJBRKM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Oct 2022 13:10:12 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E92193F2;
        Sun,  2 Oct 2022 10:10:09 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id y2so5304404qtv.5;
        Sun, 02 Oct 2022 10:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=OSpTSv+riM4KhlTnIK/5gl2tQ1eDLDkn6BHJzNZ3isg=;
        b=HCkla0geVBS5MJ4J1MBMleQoQ5Ga5xmJ/vqlEB217/AlS1ReQqGdoxZLvJiUMxjVdZ
         cvcgWKeTnZ5IcdbRn+3dAxXx3fx7EdO36VfY3+YUGSuDGF/GsHE6R0t42MmSAhHZE2Y6
         RWQgZF9efRYWMOdcNwcQx65oWJ7uYpnpQCJDzz4IlHLsc3nVlkl+lib0WSgmvV5mlxC3
         J3czD1wovvNfytK+OOE4MOVBZUA1ebucC7+llxiEuG0+6ON1SpfKZ0jpq8oE9hYh9e5G
         DR/eTnaC8gNf0felNuy20Br81F4GHTNb53uSHyGC/KmbTzvyAJNasylAMSZC4Sb1zovX
         t4xw==
X-Gm-Message-State: ACrzQf1xsw2cudFMohOTORyYOMPjt1Bk3G3yviCWbtg+aRH8crt5YmD5
        9FxUEPRy6pA/rj7gvubQZ3g=
X-Google-Smtp-Source: AMsMyM5FtTe2EKxULOtwA4xXiXrImYPxZCwwkaYzsA4YML6QEwEb1yQLGUDvmXYgg/sPyzrrbrTMTQ==
X-Received: by 2002:a05:622a:1904:b0:35c:c657:14e4 with SMTP id w4-20020a05622a190400b0035cc65714e4mr13650090qtc.65.1664730608700;
        Sun, 02 Oct 2022 10:10:08 -0700 (PDT)
Received: from localhost (c-24-15-214-156.hsd1.il.comcast.net. [24.15.214.156])
        by smtp.gmail.com with ESMTPSA id s17-20020a05620a29d100b006cbc00db595sm8971535qkp.23.2022.10.02.10.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 10:10:08 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com
Cc:     kernel-team@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yhs@fb.com, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org
Subject: [PATCH v2] selftests/bpf: Update map_kptr examples to reflect real use-cases
Date:   Sun,  2 Oct 2022 12:10:12 -0500
Message-Id: <20221002171012.3529521-1-void@manifault.com>
X-Mailer: git-send-email 2.37.3
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

In the map_kptr selftest, the bpf_kfunc_call_test_kptr_get() kfunc is used
to verify and illustrate a typical use case of kptrs wherein an additional
reference is taken on a referenced kptr that is already stored in a map.
This would be useful for programs that, for example, want to pass the
referenced kptr to a kfunc without removing it from the map.

Unfortunately, the implementation of bpf_kfunc_call_test_kptr_get() isn't
representative of a real kfunc that needs to guard against possible
refcounting races by BPF program callers. bpf_kfunc_call_test_kptr_get()
does a READ_ONCE() on the struct prog_test_ref_kfunc **pp passed by the
user and then calls refcount_inc() if the pointer is nonzero, but this
can race with another callback in the same program that removes the kptr
from the map  and frees it:

1. A BPF program with a referenced kptr in a map passes the kptr to
   bpf_kfunc_call_test_kptr_get() as:

   p = bpf_kfunc_call_test_kptr_get(&v->ref_ptr, 0, 0);

   from CPU 0.

2. bpf_kfunc_call_test_kptr_get() does READ_ONCE(), and sees that the
   struct prog_test_ref_kfunc **pp contains a non-NULL pointer.

3. Another BPF handler on CPU 1 then invokes bpf_kptr_xchg() to remove
   the kptr from the map, and frees it with a call to
   bpf_kfunc_call_test_release(). This drops the final refcount on the
   kptr.

4. CPU 0 then issues refcount_inc() on the kptr with refcount 0, causing
   a use-after-free.

In the map_kptr selftest, this doesn't cause a use-after-free because
the structure being refcounted is statically allocated, and the
refcounts aren't actually used to control the object lifecycle. In a
kfunc supporting a real use case, the refcount going to 0 would likely
cause the object to be freed, as it does for e.g. struct task_struct.

A more realistic use-case would use something like RCU in the kfunc
handler to ensure that the kptr object can be safely accessed, and then
issuing a refcount_inc_not_zero() to acquire a refcount on the object.
This patch updates the map_kptr selftest to do this.

Signed-off-by: David Vernet <void@manifault.com>
---
 net/bpf/test_run.c                            | 31 ++++++++++++++++---
 .../selftests/bpf/prog_tests/map_kptr.c       |  4 +--
 .../testing/selftests/bpf/verifier/map_kptr.c |  4 +--
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 13d578ce2a09..3fe9495abcbe 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -565,6 +565,8 @@ struct prog_test_ref_kfunc {
 	int b;
 	struct prog_test_member memb;
 	struct prog_test_ref_kfunc *next;
+	struct rcu_head rcu;
+	atomic_t destroyed;
 	refcount_t cnt;
 };
 
@@ -572,12 +574,14 @@ static struct prog_test_ref_kfunc prog_test_struct = {
 	.a = 42,
 	.b = 108,
 	.next = &prog_test_struct,
+	.destroyed = ATOMIC_INIT(0),
 	.cnt = REFCOUNT_INIT(1),
 };
 
 noinline struct prog_test_ref_kfunc *
 bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr)
 {
+	WARN_ON_ONCE(atomic_read(&prog_test_struct.destroyed));
 	refcount_inc(&prog_test_struct.cnt);
 	return &prog_test_struct;
 }
@@ -589,12 +593,22 @@ bpf_kfunc_call_memb_acquire(void)
 	return NULL;
 }
 
+static void delayed_destroy_test_ref_struct(struct rcu_head *rhp)
+{
+	struct prog_test_ref_kfunc *p = container_of(rhp, struct prog_test_ref_kfunc, rcu);
+
+	WARN_ON_ONCE(refcount_read(&p->cnt) > 0);
+	atomic_set(&p->destroyed, true);
+}
+
 noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
 {
 	if (!p)
 		return;
 
-	refcount_dec(&p->cnt);
+	WARN_ON_ONCE(atomic_read(&p->destroyed));
+	if (refcount_dec_and_test(&p->cnt))
+		call_rcu(&p->rcu, delayed_destroy_test_ref_struct);
 }
 
 noinline void bpf_kfunc_call_memb_release(struct prog_test_member *p)
@@ -641,11 +655,20 @@ noinline void bpf_kfunc_call_int_mem_release(int *p)
 noinline struct prog_test_ref_kfunc *
 bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **pp, int a, int b)
 {
-	struct prog_test_ref_kfunc *p = READ_ONCE(*pp);
+	struct prog_test_ref_kfunc *p;
 
-	if (!p)
+	rcu_read_lock();
+	p = READ_ONCE(*pp);
+	if (!p) {
+		rcu_read_unlock();
 		return NULL;
-	refcount_inc(&p->cnt);
+	}
+
+	WARN_ON_ONCE(atomic_read(&p->destroyed));
+	if (!refcount_inc_not_zero(&p->cnt))
+		p = NULL;
+	rcu_read_unlock();
+
 	return p;
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
index fdcea7a61491..1efeec146d8e 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
@@ -16,10 +16,10 @@ struct {
 	{ "non_const_var_off_kptr_xchg", "R1 doesn't have constant offset. kptr has to be" },
 	{ "misaligned_access_write", "kptr access misaligned expected=8 off=7" },
 	{ "misaligned_access_read", "kptr access misaligned expected=8 off=1" },
-	{ "reject_var_off_store", "variable untrusted_ptr_ access var_off=(0x0; 0x1e0)" },
+	{ "reject_var_off_store", "variable untrusted_ptr_ access var_off=(0x0; 0x3f0)" },
 	{ "reject_bad_type_match", "invalid kptr access, R1 type=untrusted_ptr_prog_test_ref_kfunc" },
 	{ "marked_as_untrusted_or_null", "R1 type=untrusted_ptr_or_null_ expected=percpu_ptr_" },
-	{ "correct_btf_id_check_size", "access beyond struct prog_test_ref_kfunc at off 32 size 4" },
+	{ "correct_btf_id_check_size", "access beyond struct prog_test_ref_kfunc at off 48 size 4" },
 	{ "inherit_untrusted_on_walk", "R1 type=untrusted_ptr_ expected=percpu_ptr_" },
 	{ "reject_kptr_xchg_on_unref", "off=8 kptr isn't referenced kptr" },
 	{ "reject_kptr_get_no_map_val", "arg#0 expected pointer to map value" },
diff --git a/tools/testing/selftests/bpf/verifier/map_kptr.c b/tools/testing/selftests/bpf/verifier/map_kptr.c
index 6914904344c0..d7e76cf81362 100644
--- a/tools/testing/selftests/bpf/verifier/map_kptr.c
+++ b/tools/testing/selftests/bpf/verifier/map_kptr.c
@@ -212,13 +212,13 @@
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 32),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 48),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.fixup_map_kptr = { 1 },
 	.result = REJECT,
-	.errstr = "access beyond struct prog_test_ref_kfunc at off 32 size 8",
+	.errstr = "access beyond struct prog_test_ref_kfunc at off 48 size 8",
 },
 {
 	"map_kptr: unref: inherit PTR_UNTRUSTED on struct walk",
-- 
2.37.3

