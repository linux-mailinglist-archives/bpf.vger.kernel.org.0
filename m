Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B8569C145
	for <lists+bpf@lfdr.de>; Sun, 19 Feb 2023 16:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjBSPw6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Feb 2023 10:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjBSPw5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Feb 2023 10:52:57 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59D8658B
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 07:52:55 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id ek25so2801645edb.7
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 07:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUNvfkVE+LmadH1Vh2pOdRNMkls/oHd969nUTmNAQ1g=;
        b=omIkfPU90OuLYTUlPza9jnVGuAp5dqfqgnR8v3LoUfilQzF0CkR9wUfz8Q2H2COVwv
         0tZ1gHvMi06RRj5HuHSWb4PkrPsaF2T13q6CcYk5/rZQ68SAsr+4qexYYegJUhDZvROe
         LOTyvGgiD2Z8bj3+jBZsWqNtNrXtWfS6RY/zjqlcjaJeaNCFXmUdLf75HzPshcvxUYXO
         EruQFxCWnINxu7rdRkwNrQ6OzTl1Ox7/iEwBC3b/oTRUoYPnDxpYVvB/tVZLlosASItX
         SKuFYRiNmMRMXkXRY0lMQljavW8OPGO4iw+0IY9YskMPc5ykUZnrbypAQdvqMf/lY67v
         NSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUNvfkVE+LmadH1Vh2pOdRNMkls/oHd969nUTmNAQ1g=;
        b=wIHJg0kaaGnQcgiRwhV0lrCp14lYkV1HDK5gl1Yq/E4Th+fQilDgLaQ75eFf8pmB1/
         AFlwk0Yy4lUMdgzEXGKpqUsRtyHAOf1zxIJgOuOpLoqEbGJxQkJI58Epi2syRaPsV8oo
         233/OqwSuyxz/8sGA8Y9afA/2YjObWNlKPjxgaF5A9bfCj0niFgcACS/jx0HzMsSoxDi
         8MyNHXESEDW5z6k2V9GatvUBEph11iWGUeQJ8zLrDBDRSEQzlVVEW7V+J6vS0FJTQ/4R
         9xu45BkDOvHRId2uu9P8gYpkE6uQdam4NX91hz30Ezy8k+8dtcLGbLyDUrUVBrfefAiz
         o4bg==
X-Gm-Message-State: AO0yUKXZtbtOg74+7Ibw33Keeb07GJJfrWYcMKMHyfHFOXpBZEcwbiIe
        6xjTydOfo2LDLKufg7ZM46iq5b0SCpaEqQ==
X-Google-Smtp-Source: AK7set8arj5whtYu2ObjEIxZJ2KW76Y2MqmYdLK9WUOv7xZuC7zteFPTbBgfaNYSklEV+W/DMkq+rQ==
X-Received: by 2002:a05:6402:7c2:b0:4ae:eae1:21f7 with SMTP id u2-20020a05640207c200b004aeeae121f7mr2650670edy.37.1676821973774;
        Sun, 19 Feb 2023 07:52:53 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:8d0])
        by smtp.gmail.com with ESMTPSA id m11-20020a50930b000000b004a27046b7a7sm655605eda.73.2023.02.19.07.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 07:52:53 -0800 (PST)
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
Subject: [PATCH bpf-next v1 2/7] bpf: Support kptrs in local storage maps
Date:   Sun, 19 Feb 2023 16:52:44 +0100
Message-Id: <20230219155249.1755998-3-memxor@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230219155249.1755998-1-memxor@gmail.com>
References: <20230219155249.1755998-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5277; i=memxor@gmail.com; h=from:subject; bh=IZXotWh+grGo1i9hxQm1S3jtz8ac/rLZBYeMZigpPWw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBj8kUej1ABQo1uQPzbzgNBzwI5sojqXW7Ud/sm9ahT AaaZ+HyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY/JFHgAKCRBM4MiGSL8Ryh+AD/ 9I4J0xLbi+t3dXHuMcDvGy6kyCfXmpKGoNl5xj2tIQ2D3yuAsyC0CGm5iflESj+d0WZqL1T4SY2TrD epvRbo1+2UxKpzJasx3QmhURVhbkFfHBTZeu2b1njN0ICMPjw6a30DQX9Du4wU5igaXlsQDCOTohS9 M93SHvv1Ii/1SXty8jnJH/CzNk38Etzhvj15Hy/izwt0OiAd6hbi7bPl1PTnq5KlbL0SsxGaMyEmLX jBx3r5RER0KfrWmNK+785wwhClYZa9oEGkoM7aTXl7koqvD2Y1XJeviJ8g0lNX+MQZFmI7Ne80/Jn6 sr6bj/MO6pFw7f9Ke8QkA8eIgKsxbjKfU4FgIX+X1UqJm7D1XalaaMXuDw412Fc1XkpLvzituK+h8l UyTExbz1GK8/p7kyRNHD6a9/4MgFsoAZBC/1PQU+hCEbskNLfOH5lZXxpVUpsBBqis233hXbRtYE05 cZYpSfGA3AsO9G+WN9ugdEd5QGQpNNtcdDT+1UoICBXdxl+9yR+GeYz43Oe0nzP2590d2lhMMwzRaM rZFVSHOhrXYA3M7c0p9jw3zuE+BpqakF5xu16n4hsq4n8lOeH9Yw8VSPJRUbUDR32waLZ+sxXCVY+s LypEpnDBXFEttk/IJSkJcbFaEJ17kuH3hTNyVmEfaER9//9eWWIDohUdxk/w==
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
index 35f4138a54dc..4521d53d7d4d 100644
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
+	bpf_obj_free_fields(SDATA(selem)->smap->map.record, SDATA(selem));
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

