Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41E35EE331
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 19:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbiI1Rct (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 13:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiI1Rcr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 13:32:47 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A49F2747;
        Wed, 28 Sep 2022 10:32:45 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id w9so2731781qvn.11;
        Wed, 28 Sep 2022 10:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=pRt77Yv0TW/yrDpM6cdb1Rr9JxxUCZ2+soWA4PDhyTg=;
        b=CzYXRbXgkvPvuqxPHJCHgz4Qoiqzfc4i9z38Pmakbnb2wpUCEYcVUOuzPJpUhht4XE
         idKdC0mdVLjfl9uDYCUTgUMKtpSolGBnyJyG/Jfb3UPGVHkZMLr2RLTXMjnOzeDXJmkK
         nlBCmkYslSSDwJUT0TjT0EgfehxuP7LXP6KLmKgUHjxqSyZSWtnm/TZAy9AV1ZRJpS4m
         IK7jmES8cpl7E2FB1HZnfYKpphmUqCooD7CjhAVN4a79ppiwVroe4jgPfwAA6hr8/E4C
         Vg5fO2H3qBZSUaCsI4geM+w0jRNrTjEv0aCNakv2snzKkpiNvfIbFILXrc0cEU14okSV
         08+A==
X-Gm-Message-State: ACrzQf011OnMUnKD4+99R+omxQpOYGzC4mcwNR2Eapjw+sbrEpwLi2R/
        Bj4NwqhlGYAaS2oFuC4nTzA=
X-Google-Smtp-Source: AMsMyM4u0a2O7FQXAYsIIbe/2pcw2pWXpm+RFSVtjr2qr0wEEY5m4FoZzwlUyqzYHsF5ZrbQUnKK/g==
X-Received: by 2002:a05:6214:2584:b0:4ac:7f6b:e258 with SMTP id fq4-20020a056214258400b004ac7f6be258mr26882551qvb.114.1664386364705;
        Wed, 28 Sep 2022 10:32:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::13c6])
        by smtp.gmail.com with ESMTPSA id x22-20020a05620a0b5600b006b61b2cb1d2sm3405811qkg.46.2022.09.28.10.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 10:32:44 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, haoluo@google.com, sdf@google.com,
        jolsa@kernel.org, memxor@gmail.com, tj@kernel.org
Subject: [PATCH] selftests/bpf: Update map_kptr examples to reflect real use-cases
Date:   Wed, 28 Sep 2022 12:32:46 -0500
Message-Id: <20220928173246.2094177-1-void@manifault.com>
X-Mailer: git-send-email 2.37.3
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
 net/bpf/test_run.c                            | 168 ++++++++++--------
 .../selftests/bpf/prog_tests/map_kptr.c       |   4 +-
 2 files changed, 99 insertions(+), 73 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 13d578ce2a09..23e3414b5898 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -410,73 +410,6 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 	return ret;
 }
 
-static int bpf_test_finish(const union bpf_attr *kattr,
-			   union bpf_attr __user *uattr, const void *data,
-			   struct skb_shared_info *sinfo, u32 size,
-			   u32 retval, u32 duration)
-{
-	void __user *data_out = u64_to_user_ptr(kattr->test.data_out);
-	int err = -EFAULT;
-	u32 copy_size = size;
-
-	/* Clamp copy if the user has provided a size hint, but copy the full
-	 * buffer if not to retain old behaviour.
-	 */
-	if (kattr->test.data_size_out &&
-	    copy_size > kattr->test.data_size_out) {
-		copy_size = kattr->test.data_size_out;
-		err = -ENOSPC;
-	}
-
-	if (data_out) {
-		int len = sinfo ? copy_size - sinfo->xdp_frags_size : copy_size;
-
-		if (len < 0) {
-			err = -ENOSPC;
-			goto out;
-		}
-
-		if (copy_to_user(data_out, data, len))
-			goto out;
-
-		if (sinfo) {
-			int i, offset = len;
-			u32 data_len;
-
-			for (i = 0; i < sinfo->nr_frags; i++) {
-				skb_frag_t *frag = &sinfo->frags[i];
-
-				if (offset >= copy_size) {
-					err = -ENOSPC;
-					break;
-				}
-
-				data_len = min_t(u32, copy_size - offset,
-						 skb_frag_size(frag));
-
-				if (copy_to_user(data_out + offset,
-						 skb_frag_address(frag),
-						 data_len))
-					goto out;
-
-				offset += data_len;
-			}
-		}
-	}
-
-	if (copy_to_user(&uattr->test.data_size_out, &size, sizeof(size)))
-		goto out;
-	if (copy_to_user(&uattr->test.retval, &retval, sizeof(retval)))
-		goto out;
-	if (copy_to_user(&uattr->test.duration, &duration, sizeof(duration)))
-		goto out;
-	if (err != -ENOSPC)
-		err = 0;
-out:
-	trace_bpf_test_finish(&err);
-	return err;
-}
-
 /* Integer types of various sizes and pointer combinations cover variety of
  * architecture dependent calling conventions. 7+ can be supported in the
  * future.
@@ -565,6 +498,8 @@ struct prog_test_ref_kfunc {
 	int b;
 	struct prog_test_member memb;
 	struct prog_test_ref_kfunc *next;
+	struct rcu_head rcu;
+	atomic_t destroyed;
 	refcount_t cnt;
 };
 
@@ -572,12 +507,14 @@ static struct prog_test_ref_kfunc prog_test_struct = {
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
@@ -589,12 +526,22 @@ bpf_kfunc_call_memb_acquire(void)
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
@@ -641,11 +588,20 @@ noinline void bpf_kfunc_call_int_mem_release(int *p)
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
 
@@ -783,9 +739,79 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
 		return ERR_PTR(-EFAULT);
 	}
 
+	init_rcu_head(&prog_test_struct.rcu);
+
 	return data;
 }
 
+static int bpf_test_finish(const union bpf_attr *kattr,
+			   union bpf_attr __user *uattr, const void *data,
+			   struct skb_shared_info *sinfo, u32 size,
+			   u32 retval, u32 duration)
+{
+	void __user *data_out = u64_to_user_ptr(kattr->test.data_out);
+	int err = -EFAULT;
+	u32 copy_size = size;
+
+	/* Clamp copy if the user has provided a size hint, but copy the full
+	 * buffer if not to retain old behaviour.
+	 */
+	if (kattr->test.data_size_out &&
+	    copy_size > kattr->test.data_size_out) {
+		copy_size = kattr->test.data_size_out;
+		err = -ENOSPC;
+	}
+
+	if (data_out) {
+		int len = sinfo ? copy_size - sinfo->xdp_frags_size : copy_size;
+
+		if (len < 0) {
+			err = -ENOSPC;
+			goto out;
+		}
+
+		if (copy_to_user(data_out, data, len))
+			goto out;
+
+		if (sinfo) {
+			int i, offset = len;
+			u32 data_len;
+
+			for (i = 0; i < sinfo->nr_frags; i++) {
+				skb_frag_t *frag = &sinfo->frags[i];
+
+				if (offset >= copy_size) {
+					err = -ENOSPC;
+					break;
+				}
+
+				data_len = min_t(u32, copy_size - offset,
+						 skb_frag_size(frag));
+
+				if (copy_to_user(data_out + offset,
+						 skb_frag_address(frag),
+						 data_len))
+					goto out;
+
+				offset += data_len;
+			}
+		}
+	}
+
+	if (copy_to_user(&uattr->test.data_size_out, &size, sizeof(size)))
+		goto out;
+	if (copy_to_user(&uattr->test.retval, &retval, sizeof(retval)))
+		goto out;
+	if (copy_to_user(&uattr->test.duration, &duration, sizeof(duration)))
+		goto out;
+	if (err != -ENOSPC)
+		err = 0;
+out:
+	destroy_rcu_head(&prog_test_struct.rcu);
+	trace_bpf_test_finish(&err);
+	return err;
+}
+
 int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 			      const union bpf_attr *kattr,
 			      union bpf_attr __user *uattr)
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
-- 
2.37.3

