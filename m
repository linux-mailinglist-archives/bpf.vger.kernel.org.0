Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764A369E8D1
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 21:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjBUUGx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 15:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjBUUGw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 15:06:52 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446EC27997
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 12:06:51 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id x10so21141022edd.13
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 12:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dM2SLqS21zDKJx6x4MhUEm4dpwG3TWg25MgSQwFL7Y=;
        b=MLrkiDadcb+RPuz+lXW4p0aYy7Jw1Xe9Z3W0Sl71mAeg82ivBLWL8LNUc2dJxQLHCC
         Trui4sPOaAqJTQTTZGnUk/IHsZtiW6DMOZVyNY43OsmSpbXT1NF6ep1X9dJK9cciV/v4
         Tgy9w+qqbti8xqs5Dv6ess2iXAzJu0X8PFo1RlyuB9bnIyT+o//UQJe0B6E8x9n6SZ56
         vy0KlWkTBX1nVCW40BzrIeo7+9Ga/+FUyjp/NPUCIYLu49rLCMDwnieC8j3TLija357o
         JcZfT5Rxr86LgKIKoF5TSJTnObTqxfKEab9VCx+EzWSTExnr2G/YyMIQ8hnIKTMTGwuU
         OeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dM2SLqS21zDKJx6x4MhUEm4dpwG3TWg25MgSQwFL7Y=;
        b=1rsrJ02d7/Zg89qDPeiWu/Jqhw/6prXpI3TigFWCgYnfPeQB13A4vWjSeOG0wpX3OY
         nXEZVhRfCDRs84wFve8mu7PHpC0z7rDVjE0ueD3B4Cj1LlvldIXFEoTrT2wLu3ZFP7Cc
         yEfiTQOVtvW/qBedgxwo9tVM4PIZyy73YgUfxK4YuWauCCaHtX9jh4xrArV/dDvEIzg4
         sCstik5yapJHzuXRECNY2p45e78gY1UjJuQWBP2zG+vU0F81HVGByey8KP9uwDPXA1cO
         Bj4kanaAgf4WmRzAMCf0zbN65wvQyYRYNhmUXwSh/9OcYkbfvIedzw2ybmO8OkcXS9B6
         bXuQ==
X-Gm-Message-State: AO0yUKWULxVOxZI3VZhA2xSsNJgqJoI2EHljuv2uCkkDEGKZYZvGAzbL
        yRbHPP74kJv6OH9xA6a8zjXyflFc8FX/KQ==
X-Google-Smtp-Source: AK7set8UO6/6FbZhmiqSuFIwNCDP+8gxCtiH1Xu2HtKtHpq5r+xqS6ZxDiqqhzq2IIu4A6oVLEB30w==
X-Received: by 2002:a17:907:7288:b0:8bc:9bce:7eb6 with SMTP id dt8-20020a170907728800b008bc9bce7eb6mr15626549ejc.7.1677010009291;
        Tue, 21 Feb 2023 12:06:49 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:6d0])
        by smtp.gmail.com with ESMTPSA id g9-20020a170906348900b008b11ba87bf4sm6316521ejb.209.2023.02.21.12.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:06:48 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 1/7] bpf: Support kptrs in percpu hashmap and percpu LRU hashmap
Date:   Tue, 21 Feb 2023 21:06:40 +0100
Message-Id: <20230221200646.2500777-2-memxor@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221200646.2500777-1-memxor@gmail.com>
References: <20230221200646.2500777-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6181; i=memxor@gmail.com; h=from:subject; bh=Y9p91t4feL/dpDYVE2Cl/S2CG69w6xu2l7fuqwPvi+k=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBj9SRLGndslOT9Tib4peABYZTK9T21wOGKJ4ZLkWdi FU0l8O6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY/UkSwAKCRBM4MiGSL8RyuyeD/ 9qs4+yQGJucmwwUiMhq+GCsIdau+wG/xg8mkv5ogw4Lf0Ky+YyHxMwApAfqcUer+l5Q/DT6VayK4+8 s66KK7/0Ht+BwKlAJHBKw5nI4/R+nwCYxb3H43N8r337iEuowCcjhgWAeZh/T6bIWWq0I/U6c8L30i Y594e8Y9wAN0zk289PPhz9MRksOVZkf1avymkCTfTBGMdiZpFdB7ee/npcY+lKMZEMvxhPhspZ/td2 O5CP3lL0zJN9k6kgPnU1YTKMqf6aZ21zknpnUloaHh08GcXjC9FIwgu7UdfylRqnGMVOFDwgnNpyIj /bmgeuBnp3nlBSSpv+1kySLcYurUVNu/R5omwd/cwV04z02R0aIS5DmMxS23UcGC+8A7vZodaXPc5J apBcXTi7azok3obYDgB5TEBqm9oTfUc7LaN8VqsdeD76J2ZD70JEG8ZQ+g+5ofq4XtWWtN3EfUMyyy OeY85F71h79EuQSjJaCt5vNhUpLanpBe1OE0o2yHQCzlMhabSSBh/bld4tdOJB2hWwBuZsdcPYpJwD C7PkDRlBnIG6l6bl0P6VrzMQj4hOcioQO0WF6NEAO2je2/ZSA+Y5h2wH6CpB7ctoTZDpQu6YHbj4/3 LGyoh+OTnrW54WrhV6PvYkDEA5eaLzH+/GBYpCJ2TmuXRc/TdQIqnx164yjQ==
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

