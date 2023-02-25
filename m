Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6C26A2A85
	for <lists+bpf@lfdr.de>; Sat, 25 Feb 2023 16:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjBYPkS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Feb 2023 10:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBYPkR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Feb 2023 10:40:17 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E2813D62
        for <bpf@vger.kernel.org>; Sat, 25 Feb 2023 07:40:16 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id ee7so8937367edb.2
        for <bpf@vger.kernel.org>; Sat, 25 Feb 2023 07:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dM2SLqS21zDKJx6x4MhUEm4dpwG3TWg25MgSQwFL7Y=;
        b=NIQy26HreCpFB6B15EmRcPrtWmtTD/K+pg0Mdmja7nNsA7q9aKMIRt5pU0G9dGBVHR
         bqC9B1K1j9F52+EYWL12OrQAnS5BSsEoHBNhSjRrpnQp/K/GNsS4WPBeRnYnVbUhljkL
         JZcFw/znMjguQGR5/ZMnFxJikI2gDzRYxmofKdAWo+yo7oPgN4SN1P9okAtytujj/XrC
         xyOQdLRwxA6KSTA06lpIKvP6W8j8PlZElfXgXjBCDIfwIJef0aX4MDQWns1d/t6EJylr
         ZWbMmTG/gTQ4eocwijzI/RybifnTu+B12Yr5k/6hglplISDpL0mtO/Z/dlzrPXSc91Rv
         3dHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dM2SLqS21zDKJx6x4MhUEm4dpwG3TWg25MgSQwFL7Y=;
        b=bLcRHjgJpn/EXPG2g/zIqDWn3uVuJoYunmgj2d8EByIfBfYR8gEcU9OQCFxQew9teD
         jlTGvzRYNomUwrXF4S4bZZcY6bH870uuHuZD7HtHwoQsLovxrNR3pBfXZshOb1OcD5KZ
         JQTN3XtB3m6aRX6MCqofx4CXNzD9qwpsPGzHuWrFya5aBCcrykWRw3yusVIWClwd8/PO
         f/wmwZB6X3z98y+Xs4a3/ZWSR2Vq4Q91AdopyjO/jti2Y6vWxviAsYLLxJ1l/Csf1+7t
         hSuq+hJIABHI0iM0B6sKs0MSSAaxTD5CYjaGo9rtAilwhVHHv791VVEpeq1AlOiS/5yl
         nhsQ==
X-Gm-Message-State: AO0yUKWzqbKlG0o91y+zFou7o4ZnaklMEm3fsiCpA0hXE2U8z/4lUta2
        AmGYyphnA0QmsqFP/lnG7vJ1Lb86c6jlJA==
X-Google-Smtp-Source: AK7set+B9sakDmBEmhg99pfwGezB5Xp/mdqBKF/nUpf7m0cY1/UplW5folj82o9UbYXu2Iv0piv2BQ==
X-Received: by 2002:a17:907:8743:b0:8af:2f5e:93e3 with SMTP id qo3-20020a170907874300b008af2f5e93e3mr2571238ejc.29.1677339614543;
        Sat, 25 Feb 2023 07:40:14 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:30])
        by smtp.gmail.com with ESMTPSA id u9-20020a50a409000000b004af515d2dd8sm953743edb.74.2023.02.25.07.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 07:40:14 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v3 1/3] bpf: Support kptrs in percpu hashmap and percpu LRU hashmap
Date:   Sat, 25 Feb 2023 16:40:08 +0100
Message-Id: <20230225154010.391965-2-memxor@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230225154010.391965-1-memxor@gmail.com>
References: <20230225154010.391965-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6181; i=memxor@gmail.com; h=from:subject; bh=Y9p91t4feL/dpDYVE2Cl/S2CG69w6xu2l7fuqwPvi+k=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBj+itJGndslOT9Tib4peABYZTK9T21wOGKJ4ZLkWdi FU0l8O6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY/orSQAKCRBM4MiGSL8RyjE5EA C9oNUZXiqhlzhF7Y4tnol316IKbslKsF0iT3R1lHWFZXHCdpM9QmErFLk66lifqehxltmBOhHXv0q3 t79LPFv0I6zUIjNU9Aha1kt+ALqpp70tAJKgH9nB996CBkFNZ2O7KYt4Fhg7ksrf9pwAbBwTMrRj/C DOH6s0ws/cLXZga7oAdzPavoo/Y7FaCrX8FKrXQd5PV9dJfba8imUqsE38YrKYDdkj9nQEVtqFSUDe 0BF3MWkit13mp4zeUH7Pczu1r+3mt0VYD55D7bzFpNGmbK68dU11d4A1TxinZqwsF/cW4EQfd68iUV xQ++FUGI+SJ6xPz7Rum7sIjY6/tvDZbxBokhd4Y1De+ooLpXni/fq9lxsvQK6kbVM6iJeX9CHuYlXc gvK3QSzs2Jj0g8zp/o4PhP82IX6Nos+ouiONvHxhF476t+QCD7LQF1JPbIceps6X/Yl7n9O58oD73y 8xFHHLTsJLQIjGFp7fwRduPQ5mlF1k8VWEeBh0RgX2I23u3iTCYwEGv40VMqK307dcNqPnZJHcIEC7 OJFzNvEF1+WTH6mpGyed1fnA/zv9r1aCmOrgZQOn4DtbA+60OoDVqZoeAVwL8QOL5Vj66Oo5OHvfP4 kwl93D3DnOXYBCzEnwEsrVZir8q7WbNm+0oKeBuGmtMcAVFj+TCfzE/bIxiQ==
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

