Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27366DD0B9
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 06:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjDKEQl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 00:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjDKEQk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 00:16:40 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2B52691;
        Mon, 10 Apr 2023 21:16:39 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id ay36so3905726qtb.11;
        Mon, 10 Apr 2023 21:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681186598; x=1683778598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/BJCuOQvpJU6klSzxJXEK3wu7oFUkKcR2d+BvN18us=;
        b=tUL3GiLBAUoY1UvpXJNOBneSiknOSoQUlm377M/xUiuPgobE1TZL+LPGFewEDasXWt
         83KaM6CnSfNC0wu7Fq4ukgJCVWfPAq1vwTsyeGZMybm1Wd34yLlv+M4ccL1RYmkopHrh
         mGHHxJJTbsUvLRvOkYU6nKiiJh78tHDG/xkvRfHAyLZVdgoPROwi2sTEK1bkWUQ3iOcp
         FdYZMHcKKHqENgugBVnLUYvt1yWR5PwA15JbWE2igvbUHxgFbJfiEfGc208apddU/Uxo
         vv95nweooKj/Y/gmRndvHLvNui5yu5xrCRtbUiGywFi4MCt/3PkyFECCQGMV7m02Pkzo
         aaqA==
X-Gm-Message-State: AAQBX9fBNuB5upKhZR3VermQAzXeqWvdZvJNHfHZqYkbAay1DgSHrj7t
        YPfdhEWRQDpVZqWRckw+SsJGmAQDb58dIgVx
X-Google-Smtp-Source: AKy350ZFDrf8F0+ub81rpzsEx0YL4QMarBbqLHcWNWZ1BVpKlm8dZAXmco+CUlIPxyQCsROlbJ3Wxg==
X-Received: by 2002:ac8:5c8c:0:b0:3e3:c889:ed06 with SMTP id r12-20020ac85c8c000000b003e3c889ed06mr23346779qta.21.1681186598145;
        Mon, 10 Apr 2023 21:16:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:8681])
        by smtp.gmail.com with ESMTPSA id d14-20020a05620a240e00b0071d0f1d01easm3696701qkn.57.2023.04.10.21.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 21:16:37 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 2/3] bpf: Remove bpf_cgroup_kptr_get() kfunc
Date:   Mon, 10 Apr 2023 23:16:32 -0500
Message-Id: <20230411041633.179404-2-void@manifault.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230411041633.179404-1-void@manifault.com>
References: <20230411041633.179404-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that bpf_cgroup_acquire() is KF_RCU | KF_RET_NULL,
bpf_cgroup_kptr_get() is redundant. Let's remove it, and update
selftests to instead use bpf_cgroup_acquire() where appropriate. The
next patch will update the BPF documentation to not mention
bpf_cgroup_kptr_get().

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/helpers.c                          | 32 ---------
 .../selftests/bpf/progs/cgrp_kfunc_common.h   |  3 +-
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  | 68 +++----------------
 .../selftests/bpf/progs/cgrp_kfunc_success.c  | 10 ++-
 4 files changed, 14 insertions(+), 99 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 71f0604bdc97..f04e60a4847f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2040,37 +2040,6 @@ __bpf_kfunc struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp)
 	return cgroup_tryget(cgrp) ? cgrp : NULL;
 }
 
-/**
- * bpf_cgroup_kptr_get - Acquire a reference on a struct cgroup kptr. A cgroup
- * kptr acquired by this kfunc which is not subsequently stored in a map, must
- * be released by calling bpf_cgroup_release().
- * @cgrpp: A pointer to a cgroup kptr on which a reference is being acquired.
- */
-__bpf_kfunc struct cgroup *bpf_cgroup_kptr_get(struct cgroup **cgrpp)
-{
-	struct cgroup *cgrp;
-
-	rcu_read_lock();
-	/* Another context could remove the cgroup from the map and release it
-	 * at any time, including after we've done the lookup above. This is
-	 * safe because we're in an RCU read region, so the cgroup is
-	 * guaranteed to remain valid until at least the rcu_read_unlock()
-	 * below.
-	 */
-	cgrp = READ_ONCE(*cgrpp);
-
-	if (cgrp && !cgroup_tryget(cgrp))
-		/* If the cgroup had been removed from the map and freed as
-		 * described above, cgroup_tryget() will return false. The
-		 * cgroup will be freed at some point after the current RCU gp
-		 * has ended, so just return NULL to the user.
-		 */
-		cgrp = NULL;
-	rcu_read_unlock();
-
-	return cgrp;
-}
-
 /**
  * bpf_cgroup_release - Release the reference acquired on a cgroup.
  * If this kfunc is invoked in an RCU read region, the cgroup is guaranteed to
@@ -2314,7 +2283,6 @@ BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
 
 #ifdef CONFIG_CGROUPS
 BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_cgroup_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h b/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
index b0e279f4652b..22914a70db54 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_common.h
@@ -21,10 +21,11 @@ struct hash_map {
 } __cgrps_kfunc_map SEC(".maps");
 
 struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
-struct cgroup *bpf_cgroup_kptr_get(struct cgroup **pp) __ksym;
 void bpf_cgroup_release(struct cgroup *p) __ksym;
 struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level) __ksym;
 struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
 
 static inline struct __cgrps_kfunc_map_value *cgrps_kfunc_map_value_lookup(struct cgroup *cgrp)
 {
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
index 49347f12de39..0fa564a5cc5b 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
@@ -133,59 +133,6 @@ int BPF_PROG(cgrp_kfunc_acquire_unreleased, struct cgroup *cgrp, const char *pat
 	return 0;
 }
 
-SEC("tp_btf/cgroup_mkdir")
-__failure __msg("arg#0 expected pointer to map value")
-int BPF_PROG(cgrp_kfunc_get_non_kptr_param, struct cgroup *cgrp, const char *path)
-{
-	struct cgroup *kptr;
-
-	/* Cannot use bpf_cgroup_kptr_get() on a non-kptr, even on a valid cgroup. */
-	kptr = bpf_cgroup_kptr_get(&cgrp);
-	if (!kptr)
-		return 0;
-
-	bpf_cgroup_release(kptr);
-
-	return 0;
-}
-
-SEC("tp_btf/cgroup_mkdir")
-__failure __msg("arg#0 expected pointer to map value")
-int BPF_PROG(cgrp_kfunc_get_non_kptr_acquired, struct cgroup *cgrp, const char *path)
-{
-	struct cgroup *kptr, *acquired;
-
-	acquired = bpf_cgroup_acquire(cgrp);
-	if (!acquired)
-		return 0;
-
-	/* Cannot use bpf_cgroup_kptr_get() on a non-map-value, even if the kptr was acquired. */
-	kptr = bpf_cgroup_kptr_get(&acquired);
-	bpf_cgroup_release(acquired);
-	if (!kptr)
-		return 0;
-
-	bpf_cgroup_release(kptr);
-
-	return 0;
-}
-
-SEC("tp_btf/cgroup_mkdir")
-__failure __msg("arg#0 expected pointer to map value")
-int BPF_PROG(cgrp_kfunc_get_null, struct cgroup *cgrp, const char *path)
-{
-	struct cgroup *kptr;
-
-	/* Cannot use bpf_cgroup_kptr_get() on a NULL pointer. */
-	kptr = bpf_cgroup_kptr_get(NULL);
-	if (!kptr)
-		return 0;
-
-	bpf_cgroup_release(kptr);
-
-	return 0;
-}
-
 SEC("tp_btf/cgroup_mkdir")
 __failure __msg("Unreleased reference")
 int BPF_PROG(cgrp_kfunc_xchg_unreleased, struct cgroup *cgrp, const char *path)
@@ -207,8 +154,8 @@ int BPF_PROG(cgrp_kfunc_xchg_unreleased, struct cgroup *cgrp, const char *path)
 }
 
 SEC("tp_btf/cgroup_mkdir")
-__failure __msg("Unreleased reference")
-int BPF_PROG(cgrp_kfunc_get_unreleased, struct cgroup *cgrp, const char *path)
+__failure __msg("must be referenced or trusted")
+int BPF_PROG(cgrp_kfunc_rcu_get_release, struct cgroup *cgrp, const char *path)
 {
 	struct cgroup *kptr;
 	struct __cgrps_kfunc_map_value *v;
@@ -217,11 +164,12 @@ int BPF_PROG(cgrp_kfunc_get_unreleased, struct cgroup *cgrp, const char *path)
 	if (!v)
 		return 0;
 
-	kptr = bpf_cgroup_kptr_get(&v->cgrp);
-	if (!kptr)
-		return 0;
-
-	/* Kptr acquired above is never released. */
+	bpf_rcu_read_lock();
+	kptr = v->cgrp;
+	if (kptr)
+		/* Can't release a cgroup kptr stored in a map. */
+		bpf_cgroup_release(kptr);
+	bpf_rcu_read_unlock();
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
index e9dbd1af05a7..5354455a01be 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
@@ -126,13 +126,11 @@ int BPF_PROG(test_cgrp_get_release, struct cgroup *cgrp, const char *path)
 		return 0;
 	}
 
-	kptr = bpf_cgroup_kptr_get(&v->cgrp);
-	if (!kptr) {
+	bpf_rcu_read_lock();
+	kptr = v->cgrp;
+	if (!kptr)
 		err = 3;
-		return 0;
-	}
-
-	bpf_cgroup_release(kptr);
+	bpf_rcu_read_unlock();
 
 	return 0;
 }
-- 
2.40.0

