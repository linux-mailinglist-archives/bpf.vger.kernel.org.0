Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45165AC667
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiIDUl7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiIDUl5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:41:57 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357092CDD9
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:41:56 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id u6so8974846eda.12
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nzXwSTfQYtOvsHQuyaAUpvcmg/UWG8INI3azMlcxnn8=;
        b=EVoHQ95fkIeYKtpDMdBYLULPHuSCfinZ7Vca6+xYRNh686mMPFG5nyCM6a0MlK55An
         WBb/ck8ShBdVV9xsyEu1HxzwevsSesi2vYmCU7TtU7INH/ZpJdjeU97VdtlMYrzsYB3e
         TVzhexEX7dzJbigzD15LIQpUO4Mpoi+CvwLQJQr7k0EHTNGz4G8yJRtHeIdsyQDuyeG4
         2UCk0AtSuy5CoGs5JcoMhvEpFxmVerAZZD1p4b6MhWHcxdB4mnLknS9It5p2FQn/8m4o
         yp7QcMXb1YiJ+gSJ2MR+RmS1iJrIRcusEyAIWBJJRbl2BELR+pcyFBhJUtc0lux8AoOG
         9pZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nzXwSTfQYtOvsHQuyaAUpvcmg/UWG8INI3azMlcxnn8=;
        b=LwsMu8lNuxxlo46IQhKCBb1jqemTHsui/plJCZQlJEFM6yDJwOhy+DSo4NU5rfQysI
         bhZOBbW0R2qkg0DibkBVTc66hQgve/W332h24CerRUdRnL8y2+oDeM8ucCWY8rrBvfX6
         v/4yqQGvvtinadTcsM0p2bnLMK5DR20nbtaoG1i5GHv8DNYpN7acqg+sHT/xSZ8gi4uz
         xRvVsNUoVoMPny3oUYn6elFZo8Pfa9zDV9uWrmRdT6gsbh/l5c9Xo7lu+MQICxd/7tE8
         HWkpLGKELDn97NMxiOsQk4C3+HBPX8wmpBHPx4Yi4N20ccH08VPaHweEcYEsqMrtRYtr
         dtbQ==
X-Gm-Message-State: ACgBeo27MHc+fuBCALDjAsVojSRFmcTtU5/A4FmK0h9xnxrhLNI1mdjs
        r/iv++rt6DIqbqp3pudbDDukANrPwT/QLw==
X-Google-Smtp-Source: AA6agR4QTyV7nAvyYQgt2N/pfkYFbQkGlpmA4hMBUrW0wjjPZ5b/+LXbogsp14PqyXXZoz79hv4FIw==
X-Received: by 2002:a05:6402:2945:b0:446:1144:f1aa with SMTP id ed5-20020a056402294500b004461144f1aamr40227459edb.79.1662324114519;
        Sun, 04 Sep 2022 13:41:54 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906264a00b0073cf8e0355fsm3982787ejc.208.2022.09.04.13.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:41:54 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>, KP Singh <kpsingh@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 05/32] bpf: Support kptrs in local storage maps
Date:   Sun,  4 Sep 2022 22:41:18 +0200
Message-Id: <20220904204145.3089-6-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5276; i=memxor@gmail.com; h=from:subject; bh=+QIswjv7yUNYlllWGEw1dU2rXlgH0w6Yv/JMhefDrFQ=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1v6/JxcwjtHoXxuepAO8UxdDQqpCKyC9Hcu8I6 ySWX4e+JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNbwAKCRBM4MiGSL8RyoJXD/ 92IX9BRbfzJaOsV6K25D9yq57mCe+YnbV3aDS+JE4NQ51RIUxPh/Oy27Hw31kZrQoMiX4ndDwBiTJG 0DkdTefPmIxnLPQg9PDKRcuThua+XbqmTFmM+X5buGJ4jhrbzyj4z5tynSwf7eaLfh19riHBA+Ympd 4URORP4AKfXum/yDY6oICypGk88xrsyKPzUx38DFigBg7ZlPTVJZybGKRXDL52jNSog4G6/F3ikFIO IO/AbrTyl4q8xLhTz6BZr7DqKQrzs9BNuyebu0ofhfGBSEn3eINujANm68T9vyzkruqZuPA8LBjjqk oHF6o/cVOvgffeEGgHOhZwfv3sif9m3Hfl5Tkko/3JZQfhqnBQC2KkfVQQcH0pSdO2R8UWF3S5Z8Dh 81XoTW0F73PE92jthOsAAqdhblpxWZRKZE+absDH3EhwRDxsfRo+2A8hw00Jgg5Dj+K7C62LWbZY6O CSG6RlZkv1+H806Ov2amYMTWhrPifq5wdFvKeYxBQgkgWv5SVrc/vPIAxZuhFHiwoRMKTzpXioEgWW JwI6lBeizXMKuWcwWOI5lNLZZdA7OIwB0ilnxDzmAPJp8JHHk+Uv+VA/+PvOx2awh4QVP7GiUbY42F HU0OWRRSyHH6NzPzSsZfhWo4Ny6cP1oW6MCU4nHM/7rHB7OPG3BVabqFnuoQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Enable support for kptrs in local storage maps by wiring up the freeing
of these kptrs from map value.

Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_local_storage.h |  2 +-
 kernel/bpf/bpf_local_storage.c    | 33 +++++++++++++++++++++++++++----
 kernel/bpf/syscall.c              |  5 ++++-
 kernel/bpf/verifier.c             |  9 ++++++---
 4 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 7ea18d4da84b..6786d00f004e 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -74,7 +74,7 @@ struct bpf_local_storage_elem {
 	struct hlist_node snode;	/* Linked to bpf_local_storage */
 	struct bpf_local_storage __rcu *local_storage;
 	struct rcu_head rcu;
-	/* 8 bytes hole */
+	struct bpf_map *map;		/* Only set for bpf_selem_free_rcu */
 	/* The data is stored in another cacheline to minimize
 	 * the number of cachelines access during a cache hit.
 	 */
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 802fc15b0d73..4a725379d761 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -74,7 +74,8 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 				gfp_flags | __GFP_NOWARN);
 	if (selem) {
 		if (value)
-			memcpy(SDATA(selem)->data, value, smap->map.value_size);
+			copy_map_value(&smap->map, SDATA(selem)->data, value);
+		/* No call to check_and_init_map_value as memory is zero init */
 		return selem;
 	}
 
@@ -92,12 +93,27 @@ void bpf_local_storage_free_rcu(struct rcu_head *rcu)
 	kfree_rcu(local_storage, rcu);
 }
 
+static void check_and_free_fields(struct bpf_local_storage_elem *selem)
+{
+	if (map_value_has_kptrs(selem->map))
+		bpf_map_free_kptrs(selem->map, SDATA(selem));
+}
+
 static void bpf_selem_free_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage_elem *selem;
 
 	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
-	kfree_rcu(selem, rcu);
+	check_and_free_fields(selem);
+	kfree(selem);
+}
+
+static void bpf_selem_free_tasks_trace_rcu(struct rcu_head *rcu)
+{
+	struct bpf_local_storage_elem *selem;
+
+	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
+	call_rcu(&selem->rcu, bpf_selem_free_rcu);
 }
 
 /* local_storage->lock must be held and selem->local_storage == local_storage.
@@ -150,10 +166,11 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
 	    SDATA(selem))
 		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
 
+	selem->map = &smap->map;
 	if (use_trace_rcu)
-		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
+		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_tasks_trace_rcu);
 	else
-		kfree_rcu(selem, rcu);
+		call_rcu(&selem->rcu, bpf_selem_free_rcu);
 
 	return free_local_storage;
 }
@@ -581,6 +598,14 @@ void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
 	 */
 	synchronize_rcu();
 
+	/* When local storage map has kptrs, the call_rcu callback accesses
+	 * kptr_off_tab, hence we need the bpf_selem_free_rcu callbacks to
+	 * finish before we free it.
+	 */
+	if (map_value_has_kptrs(&smap->map)) {
+		rcu_barrier();
+		bpf_map_free_kptr_off_tab(&smap->map);
+	}
 	kvfree(smap->buckets);
 	bpf_map_area_free(smap);
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3214bab5b462..0311acca19f6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1049,7 +1049,10 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 		    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
 		    map->map_type != BPF_MAP_TYPE_LRU_PERCPU_HASH &&
 		    map->map_type != BPF_MAP_TYPE_ARRAY &&
-		    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) {
+		    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY &&
+		    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
+		    map->map_type != BPF_MAP_TYPE_INODE_STORAGE &&
+		    map->map_type != BPF_MAP_TYPE_TASK_STORAGE) {
 			ret = -EOPNOTSUPP;
 			goto free_map_tab;
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0194a36d0b36..b7bf68f3b2ec 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6276,17 +6276,20 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
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
 	case BPF_MAP_TYPE_BLOOM_FILTER:
-- 
2.34.1

