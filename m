Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F4F55EB36
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 19:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbiF1Rnc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 13:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiF1Rn3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 13:43:29 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F47627A
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 10:43:23 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id e8-20020a17090301c800b0016a57150c37so7258612plh.3
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 10:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s4/kbLrmA+GqCxtr6GgURCAp2UgHA7PbHzxvCjw7LJU=;
        b=RsmPF5CKoonAP7KvCxzgPGRKK4W6KjC2qgN8gaozoBNEWRWppzKp/SzNPHP6uATevo
         R0ScRnJ/ZTH+BF8Cb4fgo1BV3X0hr2CnxaTWTaN9NHpdF7lbgEneb5PsScN0nC4wyQ+Z
         1cJP7UVwAcWfGGTEoQk3xugWaUNe2KEU4j9j2kvea9FKctW2QkRdlXZ9nfxIG5IeklH/
         ATKszXSiddlJqx+t4tQ8K6k8mTMMY/02YttVyh+jAkAq6o2qTOUGIItc2lrc9jlJwd2N
         4flUIXbSTCIsfwnsfE1l8d24GxGCDTY3qK/B58A077yKy+wamvXMPBPs2Cj+2JSuMOLm
         Z1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s4/kbLrmA+GqCxtr6GgURCAp2UgHA7PbHzxvCjw7LJU=;
        b=nOgsbzwnXatBftLq5yGY6OOPbKU9rvK0e5f8cER8o+4fLJq/6IF42NbYQ3BO93aI4w
         bmCq1x+V4SuLdq2s6z7waOlXsuYHUyAtSRU0LiLlAdetZHdVQjdXeuCBitbYX1n3baGg
         FuUQnrm2kvWqrr/8ymqa2LHJp8mAh77DpzHbJxsVz7Wt14xKwIbvkMHKqv+ArFOj1JwD
         gY7YsgwzzEbqMKqvcqKZCn/YIM2sh7UzHqI2XHsJNnCcBet661pUg2B094oGbEr2IohH
         2d3ChaQvNfkhmQlOJDd5dYBV+t7uuTgYC9SCrFLqbZ48Eoi3RvOcI3iQs3Lx7qaJWo3h
         GjIw==
X-Gm-Message-State: AJIora8+IPjb2pXe8DulQeP9UhFDTxGx7H9w7eQ12XihkUY+OJIsFMQ0
        2qJZHXYSQiXZBhzN574SsZp003A6TN3r5CJ8qIUY9CyCb/yrFVBpRIyIHQ3bu6+wtcLnWoppVS9
        +zlWaw2FmP6BTTEKT2ZpFBH1pZXCo9A6ts5XERNaw5FG3w8AEkQ==
X-Google-Smtp-Source: AGRyM1sGTAjr+zHvwvv14Aor/Rx6IsqITejgr0p2MYVg3am4z6kO5gcs8ADMXVX1p9YxVX3br9g/IoY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:2012:b0:16a:856:96a7 with SMTP id
 s18-20020a170903201200b0016a085696a7mr6130261pla.109.1656438202808; Tue, 28
 Jun 2022 10:43:22 -0700 (PDT)
Date:   Tue, 28 Jun 2022 10:43:07 -0700
In-Reply-To: <20220628174314.1216643-1-sdf@google.com>
Message-Id: <20220628174314.1216643-5-sdf@google.com>
Mime-Version: 1.0
References: <20220628174314.1216643-1-sdf@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH bpf-next v11 04/11] bpf: minimize number of allocated lsm
 slots per program
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previous patch adds 1:1 mapping between all 211 LSM hooks
and bpf_cgroup program array. Instead of reserving a slot per
possible hook, reserve 10 slots per cgroup for lsm programs.
Those slots are dynamically allocated on demand and reclaimed.

struct cgroup_bpf {
	struct bpf_prog_array *    effective[33];        /*     0   264 */
	/* --- cacheline 4 boundary (256 bytes) was 8 bytes ago --- */
	struct hlist_head          progs[33];            /*   264   264 */
	/* --- cacheline 8 boundary (512 bytes) was 16 bytes ago --- */
	u8                         flags[33];            /*   528    33 */

	/* XXX 7 bytes hole, try to pack */

	struct list_head           storages;             /*   568    16 */
	/* --- cacheline 9 boundary (576 bytes) was 8 bytes ago --- */
	struct bpf_prog_array *    inactive;             /*   584     8 */
	struct percpu_ref          refcnt;               /*   592    16 */
	struct work_struct         release_work;         /*   608    72 */

	/* size: 680, cachelines: 11, members: 7 */
	/* sum members: 673, holes: 1, sum holes: 7 */
	/* last cacheline: 40 bytes */
};

Reviewed-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf-cgroup-defs.h |  3 ++-
 include/linux/bpf.h             |  9 ++++++-
 include/linux/bpf_lsm.h         |  6 -----
 kernel/bpf/bpf_lsm.c            |  5 ----
 kernel/bpf/btf.c                | 10 -------
 kernel/bpf/cgroup.c             | 47 ++++++++++++++++++++++++++++++++-
 kernel/bpf/core.c               |  7 +++++
 kernel/bpf/trampoline.c         |  1 +
 8 files changed, 64 insertions(+), 24 deletions(-)

diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
index b99f8c3e37ea..7b121bd780eb 100644
--- a/include/linux/bpf-cgroup-defs.h
+++ b/include/linux/bpf-cgroup-defs.h
@@ -11,7 +11,8 @@
 struct bpf_prog_array;
 
 #ifdef CONFIG_BPF_LSM
-#define CGROUP_LSM_NUM 211 /* will be addressed in the next patch */
+/* Maximum number of concurrently attachable per-cgroup LSM hooks. */
+#define CGROUP_LSM_NUM 10
 #else
 #define CGROUP_LSM_NUM 0
 #endif
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 77cd613a00bd..5d2afa55c7c3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2508,7 +2508,6 @@ int bpf_arch_text_invalidate(void *dst, size_t len);
 
 struct btf_id_set;
 bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
-int btf_id_set_index(const struct btf_id_set *set, u32 id);
 
 #define MAX_BPRINTF_VARARGS		12
 
@@ -2545,4 +2544,12 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 int bpf_dynptr_check_size(u32 size);
 
+#ifdef CONFIG_BPF_LSM
+void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
+void bpf_cgroup_atype_put(int cgroup_atype);
+#else
+static inline void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype) {}
+static inline void bpf_cgroup_atype_put(int cgroup_atype) {}
+#endif /* CONFIG_BPF_LSM */
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 61787a5f6af9..4bcf76a9bb06 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -42,7 +42,6 @@ extern const struct bpf_func_proto bpf_inode_storage_get_proto;
 extern const struct bpf_func_proto bpf_inode_storage_delete_proto;
 void bpf_inode_storage_free(struct inode *inode);
 
-int bpf_lsm_hook_idx(u32 btf_id);
 void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func);
 
 #else /* !CONFIG_BPF_LSM */
@@ -73,11 +72,6 @@ static inline void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 {
 }
 
-static inline int bpf_lsm_hook_idx(u32 btf_id)
-{
-	return -EINVAL;
-}
-
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 0f72020bfdcf..83aa431dd52e 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -69,11 +69,6 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 		*bpf_func = __cgroup_bpf_run_lsm_current;
 }
 
-int bpf_lsm_hook_idx(u32 btf_id)
-{
-	return btf_id_set_index(&bpf_lsm_hooks, btf_id);
-}
-
 int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 			const struct bpf_prog *prog)
 {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7c1fe422ed3f..8d3c7ab8af46 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6843,16 +6843,6 @@ static int btf_id_cmp_func(const void *a, const void *b)
 	return *pa - *pb;
 }
 
-int btf_id_set_index(const struct btf_id_set *set, u32 id)
-{
-	const u32 *p;
-
-	p = bsearch(&id, set->ids, set->cnt, sizeof(u32), btf_id_cmp_func);
-	if (!p)
-		return -1;
-	return p - set->ids;
-}
-
 bool btf_id_set_contains(const struct btf_id_set *set, u32 id)
 {
 	return bsearch(&id, set->ids, set->cnt, sizeof(u32), btf_id_cmp_func) != NULL;
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 9cf41dd4f96f..169cbd0de797 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -127,12 +127,57 @@ unsigned int __cgroup_bpf_run_lsm_current(const void *ctx,
 }
 
 #ifdef CONFIG_BPF_LSM
+struct cgroup_lsm_atype {
+	u32 attach_btf_id;
+	int refcnt;
+};
+
+static struct cgroup_lsm_atype cgroup_lsm_atype[CGROUP_LSM_NUM];
+
 static enum cgroup_bpf_attach_type
 bpf_cgroup_atype_find(enum bpf_attach_type attach_type, u32 attach_btf_id)
 {
+	int i;
+
+	lockdep_assert_held(&cgroup_mutex);
+
 	if (attach_type != BPF_LSM_CGROUP)
 		return to_cgroup_bpf_attach_type(attach_type);
-	return CGROUP_LSM_START + bpf_lsm_hook_idx(attach_btf_id);
+
+	for (i = 0; i < ARRAY_SIZE(cgroup_lsm_atype); i++)
+		if (cgroup_lsm_atype[i].attach_btf_id == attach_btf_id)
+			return CGROUP_LSM_START + i;
+
+	for (i = 0; i < ARRAY_SIZE(cgroup_lsm_atype); i++)
+		if (cgroup_lsm_atype[i].attach_btf_id == 0)
+			return CGROUP_LSM_START + i;
+
+	return -E2BIG;
+
+}
+
+void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype)
+{
+	int i = cgroup_atype - CGROUP_LSM_START;
+
+	lockdep_assert_held(&cgroup_mutex);
+
+	WARN_ON_ONCE(cgroup_lsm_atype[i].attach_btf_id &&
+		     cgroup_lsm_atype[i].attach_btf_id != attach_btf_id);
+
+	cgroup_lsm_atype[i].attach_btf_id = attach_btf_id;
+	cgroup_lsm_atype[i].refcnt++;
+}
+
+void bpf_cgroup_atype_put(int cgroup_atype)
+{
+	int i = cgroup_atype - CGROUP_LSM_START;
+
+	mutex_lock(&cgroup_mutex);
+	if (--cgroup_lsm_atype[i].refcnt <= 0)
+		cgroup_lsm_atype[i].attach_btf_id = 0;
+	WARN_ON_ONCE(cgroup_lsm_atype[i].refcnt < 0);
+	mutex_unlock(&cgroup_mutex);
 }
 #else
 static enum cgroup_bpf_attach_type
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 4cc10b942a3c..805c2ad5c793 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -107,6 +107,9 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	fp->aux->prog = fp;
 	fp->jit_requested = ebpf_jit_enabled();
 	fp->blinding_requested = bpf_jit_blinding_enabled(fp);
+#ifdef CONFIG_CGROUP_BPF
+	aux->cgroup_atype = CGROUP_BPF_ATTACH_TYPE_INVALID;
+#endif
 
 	INIT_LIST_HEAD_RCU(&fp->aux->ksym.lnode);
 	mutex_init(&fp->aux->used_maps_mutex);
@@ -2569,6 +2572,10 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 	aux = container_of(work, struct bpf_prog_aux, work);
 #ifdef CONFIG_BPF_SYSCALL
 	bpf_free_kfunc_btf_tab(aux->kfunc_btf_tab);
+#endif
+#ifdef CONFIG_CGROUP_BPF
+	if (aux->cgroup_atype != CGROUP_BPF_ATTACH_TYPE_INVALID)
+		bpf_cgroup_atype_put(aux->cgroup_atype);
 #endif
 	bpf_free_used_maps(aux);
 	bpf_free_used_btfs(aux);
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index d7c251d7fbcd..6cd226584c33 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -555,6 +555,7 @@ static struct bpf_shim_tramp_link *cgroup_shim_alloc(const struct bpf_prog *prog
 	bpf_prog_inc(p);
 	bpf_link_init(&shim_link->link.link, BPF_LINK_TYPE_UNSPEC,
 		      &bpf_shim_tramp_link_lops, p);
+	bpf_cgroup_atype_get(p->aux->attach_btf_id, cgroup_atype);
 
 	return shim_link;
 }
-- 
2.37.0.rc0.161.g10f37bed90-goog

