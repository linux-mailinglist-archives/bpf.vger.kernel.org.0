Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9235AC67C
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiIDUm0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiIDUmS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:18 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0712CDD9
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:17 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id qh18so13445519ejb.7
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cdh5/hfW1suY8epwKPJEd7e0jLqCPuTuPd3vcn5R9JY=;
        b=QE1LOX7lAAJWrv+ZEHL4b4aB98jfxUnTu+nkS31sVK+UoEAOLuz3NJwtAEWVtDHKQy
         Rm+ygnWgx8hLIcXFpwiX28ENkWO5gchSHziD59UIrq+GjybTGs7jrPqGy27lDxpIvyLg
         EL4NRiBYJmUVv66f5urxJHNoiN2SGqnmdsORW9M6IBpSiNVnKkUNBPiHsSqKxn9FAfpa
         WGMJwnRV/u8jkKFH23z5xHUAOtJf7wv+M02d/Z/Wd81yHyhyJzzWXS2qzsZNR3oMeaeb
         2nzwwCz3UIYrK0yqaDsMKp0NDgOBoRBUCbCDybwzz+PGXP0m3uhJtgCpLzrNsz4Pdi2O
         NpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cdh5/hfW1suY8epwKPJEd7e0jLqCPuTuPd3vcn5R9JY=;
        b=HdtXNwfk93m8fPcDnyWryas8OEU6eKKxdfjHd06drpQkAuWHzNu11LabOJ3+3bHODM
         LqKQzTEM49kFDyyx1bDxsWI24Drh0Ek1u8JCjJKm3ajBXuOSyzyT5cq+PK32ZQeZNXa0
         jZ33iUeur7L1LMfb4ewndyF+SdjUBIu1racYQBItXAMmhXUoSDjf67DAKwC+OWI/4a/+
         RWeeDRAuBZy2xqpBTmL+IoNYQhyCbHHbHZZjNPrmMBsFJPshqAe4f/7ToyHXq3/MC4Pk
         cnoibx2k2oYwdlkmshgQTk5VUwL1yDPXsVJB+RDknzUialefLGwLb8lWe1fcGASp/mr3
         IpDw==
X-Gm-Message-State: ACgBeo0UMX5h/nKVYdN4lx60uCVBEmr/fLgsBK90GzCTskucAtgiJ5Cr
        fixb1/FhKpFxy/NN3k1BMvw1MaIRa0x5tQ==
X-Google-Smtp-Source: AA6agR6scP2QSKljCxSpQrxaW+V1I6d4M/NgjXthFcalxph6On1PThEZ45lDDsix62GBZ7E8apaEWA==
X-Received: by 2002:a17:907:60c7:b0:731:4b42:4e3e with SMTP id hv7-20020a17090760c700b007314b424e3emr33840708ejc.236.1662324136428;
        Sun, 04 Sep 2022 13:42:16 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id h41-20020a0564020ea900b0044629b54b00sm5279587eda.46.2022.09.04.13.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:16 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 26/32] bpf: Wire up freeing of bpf_list_heads in maps
Date:   Sun,  4 Sep 2022 22:41:39 +0200
Message-Id: <20220904204145.3089-27-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8194; i=memxor@gmail.com; h=from:subject; bh=qvn/T5tSOd3ZV5NLeRdeQfPssUjTw//0PZzifkHTk6w=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1xdpcpR8GFEHQdM1cikxPRvBIAtuLiVZqyjyri S3kDkwyJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcQAKCRBM4MiGSL8RyurjEA CvbhJ+OAYVhdTvNMhusU8395ucxo3x0n21aVTl0WE+9O1XCXv8XWdjrpuf3ooxqE8g9H9j/y1DEn0K 586iN+7oIC7cbDyG99Nclw+0J9WcjFJEju5wUjmTYELnr2TLCS2NY2v3TEDFyeV+eZEUgccVXg1tFP Q0fUzY14RwinRz/lzNho3oL4uYSrswz2TkmggDncwcebWhgpIbAecJ1OABa0AVcP4c8XcYqpNHtB6h tJ6ujWC5F01WYeU3dH3Vf3AcC3maycOadFq9FF95RHfEQVlM3kJOaCZWCjHCJ8OpKS+KopSKvgoWfr qC2y7UHooAty51hqxeyqYFYRHVZI0JUzknaS3ptBSI2iJLVEalR2t4KrPfLeE56jDkpnXuKqk2+gyw WSnwihiNq8f9GTFzSf9g6rI6C42mi6/DxQmksjkCJJv0rCsVMHQ8GRlS353wibvmbRdrmDR/jfb1Na d3ErJQIyqQqa+CozvaONU1pp6dHaU+gkq/3wrzz/JSZyJS06cBfMd+MGgIJ8o5HGUJRJunSMEbYIIe bzVcJKEFJjpLCY8YBtEF6XvofztPow1iYtLb6a1UH9m8lUyl+8SHosMYhibH/RzV6LFTXFaEgQb7e5 lDIYGF3jaCepW1GTRtC2Y3H62eC7fmi78AH0cQsA2zMckntkcbADzrX2ercw==
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

Until now, bpf_list_heads in maps were not being freed. Wire up code
needed to release them when found in map value.
This will also handle freeling local kptr with bpf_list_head in them.

Note that bpf_list_head in map value requires appropriate locking during
the draining operation.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h            |  3 +++
 kernel/bpf/arraymap.c          |  8 +++++++
 kernel/bpf/bpf_local_storage.c | 11 ++++++----
 kernel/bpf/hashtab.c           | 22 +++++++++++++++++++
 kernel/bpf/helpers.c           | 14 ++++++++++++
 kernel/bpf/syscall.c           | 39 ++++++++++++++++++++++++++++++++++
 6 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3353c47fefa9..ad18408ba442 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -381,6 +381,8 @@ static inline void zero_map_value(struct bpf_map *map, void *dst)
 
 void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
 			   bool lock_src);
+void bpf_map_value_lock(struct bpf_map *map, void *map_value);
+void bpf_map_value_unlock(struct bpf_map *map, void *map_value);
 void bpf_timer_cancel_and_free(void *timer);
 int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size);
 
@@ -1736,6 +1738,7 @@ struct bpf_map_value_off_desc *bpf_map_list_head_off_contains(struct bpf_map *ma
 void bpf_map_free_list_head_off_tab(struct bpf_map *map);
 struct bpf_map_value_off *bpf_map_copy_list_head_off_tab(const struct bpf_map *map);
 bool bpf_map_equal_list_head_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b);
+void bpf_map_free_list_heads(struct bpf_map *map, void *map_value);
 
 struct bpf_map *bpf_map_get(u32 ufd);
 struct bpf_map *bpf_map_get_with_uref(u32 ufd);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index c7263ee3a35f..5412fa66d659 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -312,6 +312,8 @@ static void check_and_free_fields(struct bpf_array *arr, void *val)
 		bpf_timer_cancel_and_free(val + arr->map.timer_off);
 	if (map_value_has_kptrs(&arr->map))
 		bpf_map_free_kptrs(&arr->map, val);
+	if (map_value_has_list_heads(&arr->map))
+		bpf_map_free_list_heads(&arr->map, val);
 }
 
 /* Called from syscall or from eBPF program */
@@ -443,6 +445,12 @@ static void array_map_free(struct bpf_map *map)
 		bpf_map_free_kptr_off_tab(map);
 	}
 
+	if (map_value_has_list_heads(map)) {
+		for (i = 0; i < array->map.max_entries; i++)
+			bpf_map_free_list_heads(map, array_map_elem_ptr(array, i));
+		bpf_map_free_list_head_off_tab(map);
+	}
+
 	if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
 		bpf_array_free_percpu(array);
 
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b5ccd76026b6..e89c6aa5d782 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -107,6 +107,8 @@ static void check_and_free_fields(struct bpf_local_storage_elem *selem)
 {
 	if (map_value_has_kptrs(selem->map))
 		bpf_map_free_kptrs(selem->map, SDATA(selem));
+	if (map_value_has_list_heads(selem->map))
+		bpf_map_free_list_heads(selem->map, SDATA(selem));
 }
 
 static void bpf_selem_free_rcu(struct rcu_head *rcu)
@@ -608,13 +610,14 @@ void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
 	 */
 	synchronize_rcu();
 
-	/* When local storage map has kptrs, the call_rcu callback accesses
-	 * kptr_off_tab, hence we need the bpf_selem_free_rcu callbacks to
-	 * finish before we free it.
+	/* When local storage map has kptrs or bpf_list_heads, the call_rcu
+	 * callback accesses kptr_off_tab or list_head_off_tab, hence we need
+	 * the bpf_selem_free_rcu callbacks to finish before we free it.
 	 */
-	if (map_value_has_kptrs(&smap->map)) {
+	if (map_value_has_kptrs(&smap->map) || map_value_has_list_heads(&smap->map)) {
 		rcu_barrier();
 		bpf_map_free_kptr_off_tab(&smap->map);
+		bpf_map_free_list_head_off_tab(&smap->map);
 	}
 	bpf_map_free_list_head_off_tab(&smap->map);
 	kvfree(smap->buckets);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 270e0ecf4ba3..bd1637fa7e3b 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -297,6 +297,25 @@ static void htab_free_prealloced_kptrs(struct bpf_htab *htab)
 	}
 }
 
+static void htab_free_prealloced_list_heads(struct bpf_htab *htab)
+{
+	u32 num_entries = htab->map.max_entries;
+	int i;
+
+	if (!map_value_has_list_heads(&htab->map))
+		return;
+	if (htab_has_extra_elems(htab))
+		num_entries += num_possible_cpus();
+
+	for (i = 0; i < num_entries; i++) {
+		struct htab_elem *elem;
+
+		elem = get_htab_elem(htab, i);
+		bpf_map_free_list_heads(&htab->map, elem->key + round_up(htab->map.key_size, 8));
+		cond_resched();
+	}
+}
+
 static void htab_free_elems(struct bpf_htab *htab)
 {
 	int i;
@@ -782,6 +801,8 @@ static void check_and_free_fields(struct bpf_htab *htab,
 			bpf_map_free_kptrs(&htab->map, map_value);
 		}
 	}
+	if (map_value_has_list_heads(&htab->map))
+		bpf_map_free_list_heads(&htab->map, map_value);
 }
 
 /* It is called from the bpf_lru_list when the LRU needs to delete
@@ -1514,6 +1535,7 @@ static void htab_map_free(struct bpf_map *map)
 	if (!htab_is_prealloc(htab)) {
 		delete_all_elements(htab);
 	} else {
+		htab_free_prealloced_list_heads(htab);
 		htab_free_prealloced_kptrs(htab);
 		prealloc_destroy(htab);
 	}
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 168460a03ec3..832dd57ae608 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -377,6 +377,20 @@ void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
 	preempt_enable();
 }
 
+void bpf_map_value_lock(struct bpf_map *map, void *map_value)
+{
+	WARN_ON_ONCE(map->spin_lock_off < 0);
+	preempt_disable();
+	__bpf_spin_lock_irqsave(map_value + map->spin_lock_off);
+}
+
+void bpf_map_value_unlock(struct bpf_map *map, void *map_value)
+{
+	WARN_ON_ONCE(map->spin_lock_off < 0);
+	__bpf_spin_unlock_irqrestore(map_value + map->spin_lock_off);
+	preempt_enable();
+}
+
 BPF_CALL_0(bpf_jiffies64)
 {
 	return get_jiffies_64();
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 1af9a7cba08c..f1e244b03382 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -600,6 +600,13 @@ static void bpf_free_local_kptr(const struct btf *btf, u32 btf_id, void *kptr)
 
 	if (!kptr)
 		return;
+	/* There is no requirement to lock the bpf_spin_lock protecting
+	 * bpf_list_head in local kptr, as these are single ownership,
+	 * so if we have access to the kptr through xchg, we own it.
+	 *
+	 * If iterating elements of bpf_list_head in map value we are
+	 * already holding the lock for it.
+	 */
 	/* We must free bpf_list_head in local kptr */
 	t = btf_type_by_id(btf, btf_id);
 	/* TODO: We should just populate this info once in struct btf, and then
@@ -697,6 +704,38 @@ bool bpf_map_equal_list_head_off_tab(const struct bpf_map *map_a, const struct b
 				       map_value_has_list_heads(map_b));
 }
 
+void bpf_map_free_list_heads(struct bpf_map *map, void *map_value)
+{
+	struct bpf_map_value_off *tab = map->list_head_off_tab;
+	int i;
+
+	/* TODO: Should we error when bpf_list_head is alone in map value,
+	 * during BTF parsing, instead of ignoring it?
+	 */
+	if (map->spin_lock_off < 0)
+		return;
+
+	bpf_map_value_lock(map, map_value);
+	for (i = 0; i < tab->nr_off; i++) {
+		struct bpf_map_value_off_desc *off_desc = &tab->off[i];
+		struct list_head *list, *olist;
+		void *entry;
+
+		olist = list = map_value + off_desc->offset;
+		list = list->next;
+		if (!list)
+			goto init;
+		while (list != olist) {
+			entry = list - off_desc->list_head.list_node_off;
+			list = list->next;
+			bpf_free_local_kptr(off_desc->list_head.btf, off_desc->list_head.value_type_id, entry);
+		}
+	init:
+		INIT_LIST_HEAD(olist);
+	}
+	bpf_map_value_unlock(map, map_value);
+}
+
 /* called from workqueue */
 static void bpf_map_free_deferred(struct work_struct *work)
 {
-- 
2.34.1

