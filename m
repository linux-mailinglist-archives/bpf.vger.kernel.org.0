Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C2E69C144
	for <lists+bpf@lfdr.de>; Sun, 19 Feb 2023 16:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjBSPw5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Feb 2023 10:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjBSPw4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Feb 2023 10:52:56 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E29A46A3
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 07:52:54 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id fd2so2644320edb.8
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 07:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dM2SLqS21zDKJx6x4MhUEm4dpwG3TWg25MgSQwFL7Y=;
        b=p/Cx8BQ/bNWHyOq19eMxASOaPwam3r8iHCShtYDfmIvQdNnls1XOBpamCAZVTLJy+n
         ht5a6AZ3Gp3H5TIrVZtSCE3yhgWDJ76YOh0ECyGzYoHJMO9H+Nfs9GYgLvws/g+U3jm5
         4WrdhfvUfq7zcsruokgnE9oQnsMENQ98qeny0wqHSOECXOwEygpHP2zadXQuqrxR4Y0w
         a2BkYoN1pFbx1WxdwzFDlN0u31X7tvHHzeaT7rLptwn9RL5LoIP7NxhjNHBiqtUZuhcq
         civRwfCXN8EzWJk/WbfehcZ8Ag0pEnJYSqx8IQoT085ax67wA5PPtvKYUAu3Ddkbovfn
         SS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dM2SLqS21zDKJx6x4MhUEm4dpwG3TWg25MgSQwFL7Y=;
        b=EvpyaPeQTwTLmncNDImVeUNQ/rAAI5b5RXunypEqr7f9M9Ulxdu7LBqck3zNLuJFqm
         D7FzEyyFXJoeaDg0O2A/JOfsactuWQuOeLZEir5VjkJ88tjFUMqjUPsZ1wWvgOz/7oug
         cQNvkX3hzzEjStL2n4XJCXM8E2S41g9YEpdOWRmwVLo7md6ShU03W/YPHHeYR+LJwTq0
         zjTfVu2EzplpnBUP2whXzVTLVzEB0w9LaQsY9jiRcaGt124neb4L6quFRpqFaqIB4HAV
         XnLtjJw5hy/WBZ9Y3ntG3Y/brBDgwSlR2lxiYKC3hZ6nT6nuUzpYsuvHH5GXs/pswPtL
         UkKQ==
X-Gm-Message-State: AO0yUKVf0UWy97OU6oEdVnvZRfyVE14GGZDGgmI21BgBzIvm1vDf05RT
        ef+23U73Lm6r6NrkXRCPgVKWTZlV9TsNmw==
X-Google-Smtp-Source: AK7set9ndrfBZfMG7t0SfgNxMRqLIjG5utl+uj0TjZ2HK+lC+MX5PuL6urC+P+PGgqKxVnuPwThLvw==
X-Received: by 2002:a17:906:4f84:b0:8b1:32b0:2a25 with SMTP id o4-20020a1709064f8400b008b132b02a25mr7209943eju.10.1676821972226;
        Sun, 19 Feb 2023 07:52:52 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:8d0])
        by smtp.gmail.com with ESMTPSA id jy28-20020a170907763c00b008b17b123a47sm3702778ejc.208.2023.02.19.07.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 07:52:51 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 1/7] bpf: Support kptrs in percpu hashmap and percpu LRU hashmap
Date:   Sun, 19 Feb 2023 16:52:43 +0100
Message-Id: <20230219155249.1755998-2-memxor@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230219155249.1755998-1-memxor@gmail.com>
References: <20230219155249.1755998-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6181; i=memxor@gmail.com; h=from:subject; bh=Y9p91t4feL/dpDYVE2Cl/S2CG69w6xu2l7fuqwPvi+k=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBj8kUeGndslOT9Tib4peABYZTK9T21wOGKJ4ZLkWdi FU0l8O6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY/JFHgAKCRBM4MiGSL8RyhbNEA CaMQBzosGGX+I2vdqvxt8SW9ldwRwtiPeDVRX53iNeWVZGtj8RmTg4A6Bombpbq/MOMdItIEImpQkJ lVz1H4DAYosLZLRwLPWubn4FnRQqcBA+GYQGFqysuaExptNuhkOWhb4qWD01gHOXJ4XcnN3T33BF6p 79PfpQCSXmEywRe7jqtHNPGI60CqzIVNaIEzIjwHV692VT1jTYIGRY3t8ofRKa8dvck+KrcQyPqJi0 ajusM56iZgQ1eAdDeIJIUwpxj1npa41aApd6X7t85H3D4cNFo0U/mmztJ6MzSEBWrscn0nkSBWzpOm 0hiYTEyH7Gs/gyjcVJbkluKHepy+gffWHdlM6FQceHszg1C2KNPMKuyR4mTxclg4DscOcMkTKTGTbm Tj3raoTMIFZwiMyyNSrigkNSKhS98vxIJb583TVPX7VK+CGWZGb1oeSCgkPGUtWLvd0vCUBKWZIQa3 hCfkVzsBBPKUHaQ64m2WNQrL5v4eNy5gRWtiPMOWHXJkyH4UXLBtDjTZoEL2SPt0IryC1sQxRhHrBy UoRF4r5K0ZYwcFVvhtLMTeBkGIqZ0ZWCgKyf/3jEKZLmfQogfVx4t6pwWdOiR6vY0YZJivFP09RhZJ kvEe1aAIXU9ghycNTNJCvjbsEFM+8z1hgFIyAlqkOJifgFmttUKEZmulqC3Q==
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

Enable support for kptrs in percpu BPF hashmap and percpu BPF LRU
hashmap by wiring up the freeing of these kptrs from percpu map
elements.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/hashtab.c | 59 +++++++++++++++++++++++++++-----------------
 kernel/bpf/syscall.c |  2 ++
 2 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 5dfcb5ad0d06..653aeb481c79 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -249,7 +249,18 @@ static void htab_free_prealloced_fields(struct bpf_htab *htab)
 		struct htab_elem *elem;
 
 		elem = get_htab_elem(htab, i);
-		bpf_obj_free_fields(htab->map.record, elem->key + round_up(htab->map.key_size, 8));
+		if (htab_is_percpu(htab)) {
+			void __percpu *pptr = htab_elem_get_ptr(elem, htab->map.key_size);
+			int cpu;
+
+			for_each_possible_cpu(cpu) {
+				bpf_obj_free_fields(htab->map.record, per_cpu_ptr(pptr, cpu));
+				cond_resched();
+			}
+		} else {
+			bpf_obj_free_fields(htab->map.record, elem->key + round_up(htab->map.key_size, 8));
+			cond_resched();
+		}
 		cond_resched();
 	}
 }
@@ -759,9 +770,17 @@ static int htab_lru_map_gen_lookup(struct bpf_map *map,
 static void check_and_free_fields(struct bpf_htab *htab,
 				  struct htab_elem *elem)
 {
-	void *map_value = elem->key + round_up(htab->map.key_size, 8);
+	if (htab_is_percpu(htab)) {
+		void __percpu *pptr = htab_elem_get_ptr(elem, htab->map.key_size);
+		int cpu;
 
-	bpf_obj_free_fields(htab->map.record, map_value);
+		for_each_possible_cpu(cpu)
+			bpf_obj_free_fields(htab->map.record, per_cpu_ptr(pptr, cpu));
+	} else {
+		void *map_value = elem->key + round_up(htab->map.key_size, 8);
+
+		bpf_obj_free_fields(htab->map.record, map_value);
+	}
 }
 
 /* It is called from the bpf_lru_list when the LRU needs to delete
@@ -858,9 +877,9 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 {
+	check_and_free_fields(htab, l);
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
 		bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
-	check_and_free_fields(htab, l);
 	bpf_mem_cache_free(&htab->ma, l);
 }
 
@@ -918,14 +937,13 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
 {
 	if (!onallcpus) {
 		/* copy true value_size bytes */
-		memcpy(this_cpu_ptr(pptr), value, htab->map.value_size);
+		copy_map_value(&htab->map, this_cpu_ptr(pptr), value);
 	} else {
 		u32 size = round_up(htab->map.value_size, 8);
 		int off = 0, cpu;
 
 		for_each_possible_cpu(cpu) {
-			bpf_long_memcpy(per_cpu_ptr(pptr, cpu),
-					value + off, size);
+			copy_map_value_long(&htab->map, per_cpu_ptr(pptr, cpu), value + off);
 			off += size;
 		}
 	}
@@ -940,16 +958,14 @@ static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
 	 * (onallcpus=false always when coming from bpf prog).
 	 */
 	if (!onallcpus) {
-		u32 size = round_up(htab->map.value_size, 8);
 		int current_cpu = raw_smp_processor_id();
 		int cpu;
 
 		for_each_possible_cpu(cpu) {
 			if (cpu == current_cpu)
-				bpf_long_memcpy(per_cpu_ptr(pptr, cpu), value,
-						size);
-			else
-				memset(per_cpu_ptr(pptr, cpu), 0, size);
+				copy_map_value_long(&htab->map, per_cpu_ptr(pptr, cpu), value);
+			else /* Since elem is preallocated, we cannot touch special fields */
+				zero_map_value(&htab->map, per_cpu_ptr(pptr, cpu));
 		}
 	} else {
 		pcpu_copy_value(htab, pptr, value, onallcpus);
@@ -1575,9 +1591,8 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 
 			pptr = htab_elem_get_ptr(l, key_size);
 			for_each_possible_cpu(cpu) {
-				bpf_long_memcpy(value + off,
-						per_cpu_ptr(pptr, cpu),
-						roundup_value_size);
+				copy_map_value_long(&htab->map, value + off, per_cpu_ptr(pptr, cpu));
+				check_and_init_map_value(&htab->map, value + off);
 				off += roundup_value_size;
 			}
 		} else {
@@ -1772,8 +1787,8 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 
 			pptr = htab_elem_get_ptr(l, map->key_size);
 			for_each_possible_cpu(cpu) {
-				bpf_long_memcpy(dst_val + off,
-						per_cpu_ptr(pptr, cpu), size);
+				copy_map_value_long(&htab->map, dst_val + off, per_cpu_ptr(pptr, cpu));
+				check_and_init_map_value(&htab->map, dst_val + off);
 				off += size;
 			}
 		} else {
@@ -2046,9 +2061,9 @@ static int __bpf_hash_map_seq_show(struct seq_file *seq, struct htab_elem *elem)
 				roundup_value_size = round_up(map->value_size, 8);
 				pptr = htab_elem_get_ptr(elem, map->key_size);
 				for_each_possible_cpu(cpu) {
-					bpf_long_memcpy(info->percpu_value_buf + off,
-							per_cpu_ptr(pptr, cpu),
-							roundup_value_size);
+					copy_map_value_long(map, info->percpu_value_buf + off,
+							    per_cpu_ptr(pptr, cpu));
+					check_and_init_map_value(map, info->percpu_value_buf + off);
 					off += roundup_value_size;
 				}
 				ctx.value = info->percpu_value_buf;
@@ -2292,8 +2307,8 @@ int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value)
 	 */
 	pptr = htab_elem_get_ptr(l, map->key_size);
 	for_each_possible_cpu(cpu) {
-		bpf_long_memcpy(value + off,
-				per_cpu_ptr(pptr, cpu), size);
+		copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
+		check_and_init_map_value(map, value + off);
 		off += size;
 	}
 	ret = 0;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e3fcdc9836a6..da117a2a83b2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1059,7 +1059,9 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 			case BPF_KPTR_UNREF:
 			case BPF_KPTR_REF:
 				if (map->map_type != BPF_MAP_TYPE_HASH &&
+				    map->map_type != BPF_MAP_TYPE_PERCPU_HASH &&
 				    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
+				    map->map_type != BPF_MAP_TYPE_LRU_PERCPU_HASH &&
 				    map->map_type != BPF_MAP_TYPE_ARRAY &&
 				    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) {
 					ret = -EOPNOTSUPP;
-- 
2.39.2

