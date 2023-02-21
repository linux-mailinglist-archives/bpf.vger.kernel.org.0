Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11CB69E8D2
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 21:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjBUUGy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 15:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjBUUGy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 15:06:54 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DF130B3F
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 12:06:52 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id x10so21141216edd.13
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 12:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LChYyXkhlE5HW9JG8xAPc5FXE/dZC/OSRTkTH6gnD4=;
        b=egUjmMBasbupOim318P/hqQYKjjT9ALuk+C02Lw6cLkwWWrJOIDlF5d2fBAfwtNxwN
         bZx2iI+bfDV3rNWuqMpnMVpPjwHU8TvJS16oBvwIFtAtLbrxW8t3PylpiO4NEXSlbAQT
         kD7r7rPPQzdipJ3v090MeMmpsVYPv2vlT0AmAzVyY1sy5l913wUUoPZ05ibrYTVD+EoO
         Qtt3aqFvKwy7Uqsw44ZsOTZS1q/fmGfeAInyfzt7fjTPp/Ypg3gHG9lKY9MIKlrJlJHu
         BZ5536nsHEp1mJHOET6N+UXR/4DwKDe4cMaR9f+3tjrkDgXtnxT5e28FmhLDVet5zJ1x
         Btvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LChYyXkhlE5HW9JG8xAPc5FXE/dZC/OSRTkTH6gnD4=;
        b=GIww3HynJVrkTnT70uk2p/fGC4XtkrWBvxepQs6abT3+x3ZgInZrcIqGronEucSJ7m
         xzcxRCRNfRJJ/fyd85RSBpAPfPQvpynJAW8hHq1AxwkwPZtdfCVNApeXjXHrgcGBWttg
         bJV9OP7bIqkWq3piHabEzaybuvJ5w8AxOWE8SiHBMrv9/dQdLWFuud5/EtcCH2Tk7//q
         15QEd5J9Ab32LgOWatW6g5SuA3/KvaCD3Ov13qepKodJoKpBkIDjlwVJYNPYsOR8u/lz
         1pFXOgbvrQeGjnK9vkMG6ecv+VUIDL/QHskmDDLFah+G9ZsxUnX43czIghyso8p82Sot
         jlyg==
X-Gm-Message-State: AO0yUKWWx1IOIeDkCg74lv/TeKEx5GSYP8fpLdjzEKLBwtGZCT1XHCUK
        ChdlPR/sGfU/gF678gfNLlzOvcVzyKTr/g==
X-Google-Smtp-Source: AK7set80GD/iBVLGWzoZTeYV7XzkRfg2MRm/lEFs8U441a647/3W2w2KWclT08QIrUBzOgvNBnX+gw==
X-Received: by 2002:a17:906:f88a:b0:8b1:32dd:3af with SMTP id lg10-20020a170906f88a00b008b132dd03afmr13655893ejb.28.1677010010514;
        Tue, 21 Feb 2023 12:06:50 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:6d0])
        by smtp.gmail.com with ESMTPSA id s23-20020a170906501700b008b10d5b092csm7438526ejj.119.2023.02.21.12.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:06:50 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 2/7] bpf: Support kptrs in local storage maps
Date:   Tue, 21 Feb 2023 21:06:41 +0100
Message-Id: <20230221200646.2500777-3-memxor@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221200646.2500777-1-memxor@gmail.com>
References: <20230221200646.2500777-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5283; i=memxor@gmail.com; h=from:subject; bh=/IKK2SSxTO6Dvec4kNAJOkXu2gKi23SAmz4Xy39MaTw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBj9SRLHp1PqjC3dbF4QiT1W026xEc7xJpizYBuOiiT JJFTLC2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY/UkSwAKCRBM4MiGSL8RypT3D/ 929+4uDey8iVj8yHNe5lXGnK46+ZWSG8vEnDJi7rQ0b59EyH+3UaL4G/Ttz53f5Z92pLD7loZGOTSk zbQZmD86aDJ29CYypBSiorQYPHxOlFWkqlsItR5DMPe/OG4usCxYhpCQx3wJR2AsVILBK9wc3m3a2d WvEcz2QwJ4o8bYzHK/6ct+nax2jeEJm+JoY8UYuRx0v+FDxN0kwrGTFq/waKMWqlxjwdx6EXLQicg/ xPliadgt78XmtK70jNFKPk84YS1jldEMAtXcQHe3xHFBp9omFu5ExjjQ8ghFEOGKAh1fLzAkSiYFtd M5uaciBLy+foPC6OAJhGIWUqolH9b/BA3uNPzd+DSUZy5xLnfEx1jKSKMeSquyUuGNLdnWzcFBhIEO 76VAjP1c+cQjYP8V29T4VhM2JdhuPBRM5rXpMFvbdVq+9uWVw3EwCMRdkS9/DclxCv6Zm7qDcgQzDY vbQPdnk/RzOOXRGYJqVfN5SblEKeBmgUiYa7rTfBVliiQgeTpUDApYQoqgVyc3NPCWOEvhU6dC2Bu1 iBD7fS4ACuKjWZls1Kmz4mcS8j424bnYRrJ8NCp5oIDKbmaO11DJZ8E+IQAahCUzi/BtTBZggWP4Gv UUqtO1gf41Y6vtTxub79YG4hCm/jgKolf4aIrpXv2mLuKvXu6wLye7iuHd2Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Enable support for kptrs in local storage maps by wiring up the freeing
of these kptrs from map value.

Cc: Martin KaFai Lau <martin.lau@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 35 ++++++++++++++++++++++++++++++----
 kernel/bpf/syscall.c           |  6 +++++-
 kernel/bpf/verifier.c          | 12 ++++++++----
 3 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 35f4138a54dc..2803b85b30b2 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -75,6 +75,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	if (selem) {
 		if (value)
 			copy_map_value(&smap->map, SDATA(selem)->data, value);
+		/* No need to call check_and_init_map_value as memory is zero init */
 		return selem;
 	}
 
@@ -103,10 +104,17 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
 	struct bpf_local_storage_elem *selem;
 
 	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
+	bpf_obj_free_fields(SDATA(selem)->smap->map.record, SDATA(selem)->data);
+	kfree(selem);
+}
+
+static void bpf_selem_free_tasks_trace_rcu(struct rcu_head *rcu)
+{
+	/* Free directly if Tasks Trace RCU GP also implies RCU GP */
 	if (rcu_trace_implies_rcu_gp())
-		kfree(selem);
+		bpf_selem_free_rcu(rcu);
 	else
-		kfree_rcu(selem, rcu);
+		call_rcu(rcu, bpf_selem_free_rcu);
 }
 
 /* local_storage->lock must be held and selem->local_storage == local_storage.
@@ -160,9 +168,9 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
 
 	if (use_trace_rcu)
-		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
+		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_tasks_trace_rcu);
 	else
-		kfree_rcu(selem, rcu);
+		call_rcu(&selem->rcu, bpf_selem_free_rcu);
 
 	return free_local_storage;
 }
@@ -713,6 +721,25 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 	 */
 	synchronize_rcu();
 
+	/* Only delay freeing of smap, buckets are not needed anymore */
 	kvfree(smap->buckets);
+
+	/* When local storage has special fields, callbacks for
+	 * bpf_selem_free_rcu and bpf_selem_free_tasks_trace_rcu will keep using
+	 * the map BTF record, we need to execute an RCU barrier to wait for
+	 * them as the record will be freed right after our map_free callback.
+	 */
+	if (!IS_ERR_OR_NULL(smap->map.record)) {
+		rcu_barrier_tasks_trace();
+		/* We cannot skip rcu_barrier() when rcu_trace_implies_rcu_gp()
+		 * is true, because while call_rcu invocation is skipped in that
+		 * case in bpf_selem_free_tasks_trace_rcu (and all local storage
+		 * maps pass use_trace_rcu = true), there can be call_rcu
+		 * callbacks based on use_trace_rcu = false in the earlier while
+		 * ((selem = ...)) loop or from bpf_local_storage_unlink_nolock
+		 * called from owner's free path.
+		 */
+		rcu_barrier();
+	}
 	bpf_map_area_free(smap);
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index da117a2a83b2..eb50025b03c1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1063,7 +1063,11 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 				    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
 				    map->map_type != BPF_MAP_TYPE_LRU_PERCPU_HASH &&
 				    map->map_type != BPF_MAP_TYPE_ARRAY &&
-				    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) {
+				    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY &&
+				    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
+				    map->map_type != BPF_MAP_TYPE_INODE_STORAGE &&
+				    map->map_type != BPF_MAP_TYPE_TASK_STORAGE &&
+				    map->map_type != BPF_MAP_TYPE_CGRP_STORAGE) {
 					ret = -EOPNOTSUPP;
 					goto free_map_tab;
 				}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 272563a0b770..9a4e7efaf28f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7126,22 +7126,26 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		break;
 	case BPF_MAP_TYPE_SK_STORAGE:
 		if (func_id != BPF_FUNC_sk_storage_get &&
-		    func_id != BPF_FUNC_sk_storage_delete)
+		    func_id != BPF_FUNC_sk_storage_delete &&
+		    func_id != BPF_FUNC_kptr_xchg)
 			goto error;
 		break;
 	case BPF_MAP_TYPE_INODE_STORAGE:
 		if (func_id != BPF_FUNC_inode_storage_get &&
-		    func_id != BPF_FUNC_inode_storage_delete)
+		    func_id != BPF_FUNC_inode_storage_delete &&
+		    func_id != BPF_FUNC_kptr_xchg)
 			goto error;
 		break;
 	case BPF_MAP_TYPE_TASK_STORAGE:
 		if (func_id != BPF_FUNC_task_storage_get &&
-		    func_id != BPF_FUNC_task_storage_delete)
+		    func_id != BPF_FUNC_task_storage_delete &&
+		    func_id != BPF_FUNC_kptr_xchg)
 			goto error;
 		break;
 	case BPF_MAP_TYPE_CGRP_STORAGE:
 		if (func_id != BPF_FUNC_cgrp_storage_get &&
-		    func_id != BPF_FUNC_cgrp_storage_delete)
+		    func_id != BPF_FUNC_cgrp_storage_delete &&
+		    func_id != BPF_FUNC_kptr_xchg)
 			goto error;
 		break;
 	case BPF_MAP_TYPE_BLOOM_FILTER:
-- 
2.39.2

