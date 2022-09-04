Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A94C5AC666
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbiIDUl7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiIDUl4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:41:56 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC7B2CDD8
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:41:55 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w2so9103692edc.0
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=c+/tCo9lbDnMh4sWJ3YLX48wAvGVtBIvuE9il4KVLLc=;
        b=eXs9D67fIFZ+XnCYtrIpV+DAddxZOluwNQwOEIu18smNXRiuDO1sbupP7/bjKyDIqG
         bwomHwGHdKrxNl8M4rQPFgFbIyuu6OVWBKtierdp6voRLtIicWp2vKyVpO1b8++i56YC
         E/CcXv1wmb4LgnbM8oCCSX1wi7leWZH/q8RPjZX4GEQkEnzhymqccOfKTifcz50mk8d4
         /5SQtFK4Ww3KZhEHmGYrkm6wBnrAv848nHiG39L+3jW/CJOfJB5y8ke1SUS8Ws3L3IJD
         fcDKUaYD8pWgCcoCGdptJ2oyUJQXMvwlJkywkiBq8f3rPDyaJiok4gKnaM1VUemfOE+7
         vA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=c+/tCo9lbDnMh4sWJ3YLX48wAvGVtBIvuE9il4KVLLc=;
        b=dyrhXedJBZBbTiWW+6EaHHfevhn7IAaU8pAKh7HEpSp4o1M3MTtNWFehVRApumPNYz
         JCsURdRhI0FoDA6vSM6muf6AehFH7eizJ01oMSTVOGVzwrVXkUdDP/oR56m9WO6yg92Z
         3OZATKZQdjXSXACC0055cLo4tOT/ZBZjZr+jgQZQtpTUp09DOL34sDi+sot6IdLBvQ43
         klVn96eqsKucnu43pBId8/lnPgfmA2Y8VrM5u0KFRAwWSSGWUBO/DyGmrrEfURgJIPJx
         FJ4LZa7XfVdtnvdjzQnoyyAx6/vLX44xD7g+dPnK/xkbiNfgvlhbNvGggSDwqWDN+jm0
         PhlQ==
X-Gm-Message-State: ACgBeo0pjPSeLwn1ViKJSZcuFAUKWXAhsGlzRO3/T6nHvWz2CRuwj1T+
        /S0tMfUm6NyR7S26hHUcuPeaey7330QxLg==
X-Google-Smtp-Source: AA6agR6AVvjb9TyGHdfnUBaSjmtCHLYYNVckCK3ImQmlbXvUM2jU8AsX8difbq/SGh9a4eB5f+GhVw==
X-Received: by 2002:a05:6402:241e:b0:443:be9:83c0 with SMTP id t30-20020a056402241e00b004430be983c0mr41670365eda.24.1662324113523;
        Sun, 04 Sep 2022 13:41:53 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id kx3-20020a170907774300b007314a01766asm4088980ejc.211.2022.09.04.13.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:41:53 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 04/32] bpf: Support kptrs in percpu hashmap and percpu LRU hashmap
Date:   Sun,  4 Sep 2022 22:41:17 +0200
Message-Id: <20220904204145.3089-5-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6519; i=memxor@gmail.com; h=from:subject; bh=flz/5WZoaVz0w0lh/BxWuOIIoM+tst2aUfr4CwqrJJ4=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1vRIaMRJHYhv+n9HqyPrjQvrn3ypcDRL/Rhd9K hKLJahqJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNbwAKCRBM4MiGSL8Ryp7tEA DDXYJGs42lbjCL78bS/dzbLcML7zftBLImeElw0fxv5O3yx1mFrPUsadIt1EOkxgIo9aWTIQD+jfju tDm2hCbp1IuVaW/r/ZWxCgz5vNC4n67kYVlAzo5QxeBs4RTVFrWq4iJ/DbV2sDUn9WsrcmTIanfcMb Zb2A1gBz4F8tfFgfU+IdIj0u4gA1/PtlIviVxA65WKFZoVVH3fSPpLPAMY6XkNIJgMQ2ejgfB+LAG6 v67V2WNWQhMRRXdhb8BSSsdvm3BcVjyTgCgleXDwaE5rxmWbiZKBX9HKniIIHeJZs5uMXsli/aG7sv EIH3w6HlwKGlWtcYY9L/gzf8PCi+MduSo2t8JxN+vaT61ljSkzxjjpXUFr6XWrUxGNW2nP0szMG6eV XgdWXl0eAXaZ2dg+Khdej804b7KtiOd5pxrA0e2pfl/6+YhkEHjFwUvWVojG/SUJQQ1hN6gVjljHgM /bbojHEcBliETA6KyCQGQvFZh8jPASGAHdUp1m7hJc4UwblfLkX3enpD5Vpx34PJjG67LDYwrEn+eQ Y7+kw9M3jhH9H+kiMlfpgejVIuNvXaVprtvj4FTVZ7M51/ozcqqDmDSn1l092hJaNmSxY9q+OvDJHp vv2lb5Wbs5O29aUUWrlzEz8iSzhsuwtgcKkvu5NLTDWYQsiNHzU9bCsS70QA==
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

Enable support for kptrs in percpu BPF hashmap and percpu BPF LRU
hashmap by wiring up the freeing of these kptrs from percpu map
elements.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/hashtab.c | 70 ++++++++++++++++++++++++++++----------------
 kernel/bpf/syscall.c |  2 ++
 2 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index eb1263f03e9b..bb3f8a63c221 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -282,8 +282,18 @@ static void htab_free_prealloced_kptrs(struct bpf_htab *htab)
 		struct htab_elem *elem;
 
 		elem = get_htab_elem(htab, i);
-		bpf_map_free_kptrs(&htab->map, elem->key + round_up(htab->map.key_size, 8));
-		cond_resched();
+		if (htab_is_percpu(htab)) {
+			void __percpu *pptr = htab_elem_get_ptr(elem, htab->map.key_size);
+			int cpu;
+
+			for_each_possible_cpu(cpu) {
+				bpf_map_free_kptrs(&htab->map, per_cpu_ptr(pptr, cpu));
+				cond_resched();
+			}
+		} else {
+			bpf_map_free_kptrs(&htab->map, elem->key + round_up(htab->map.key_size, 8));
+			cond_resched();
+		}
 	}
 }
 
@@ -761,8 +771,17 @@ static void check_and_free_fields(struct bpf_htab *htab,
 
 	if (map_value_has_timer(&htab->map))
 		bpf_timer_cancel_and_free(map_value + htab->map.timer_off);
-	if (map_value_has_kptrs(&htab->map))
-		bpf_map_free_kptrs(&htab->map, map_value);
+	if (map_value_has_kptrs(&htab->map)) {
+		if (htab_is_percpu(htab)) {
+			void __percpu *pptr = htab_elem_get_ptr(elem, htab->map.key_size);
+			int cpu;
+
+			for_each_possible_cpu(cpu)
+				bpf_map_free_kptrs(&htab->map, per_cpu_ptr(pptr, cpu));
+		} else {
+			bpf_map_free_kptrs(&htab->map, map_value);
+		}
+	}
 }
 
 /* It is called from the bpf_lru_list when the LRU needs to delete
@@ -859,9 +878,9 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 {
+	check_and_free_fields(htab, l);
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
 		free_percpu(htab_elem_get_ptr(l, htab->map.key_size));
-	check_and_free_fields(htab, l);
 	kfree(l);
 }
 
@@ -903,14 +922,13 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
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
@@ -926,16 +944,16 @@ static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
 	 * (onallcpus=false always when coming from bpf prog).
 	 */
 	if (htab_is_prealloc(htab) && !onallcpus) {
-		u32 size = round_up(htab->map.value_size, 8);
 		int current_cpu = raw_smp_processor_id();
 		int cpu;
 
 		for_each_possible_cpu(cpu) {
-			if (cpu == current_cpu)
-				bpf_long_memcpy(per_cpu_ptr(pptr, cpu), value,
-						size);
-			else
-				memset(per_cpu_ptr(pptr, cpu), 0, size);
+			if (cpu == current_cpu) {
+				copy_map_value_long(&htab->map, per_cpu_ptr(pptr, cpu), value);
+			} else {
+				/* Since elem is preallocated, we cannot touch special fields */
+				zero_map_value(&htab->map, per_cpu_ptr(pptr, cpu));
+			}
 		}
 	} else {
 		pcpu_copy_value(htab, pptr, value, onallcpus);
@@ -993,8 +1011,9 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			l_new = ERR_PTR(-ENOMEM);
 			goto dec_count;
 		}
-		check_and_init_map_value(&htab->map,
-					 l_new->key + round_up(key_size, 8));
+
+		if (!percpu)
+			check_and_init_map_value(&htab->map, l_new->key + round_up(key_size, 8));
 	}
 
 	memcpy(l_new->key, key, key_size);
@@ -1562,9 +1581,8 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 
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
@@ -1758,8 +1776,8 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 
 			pptr = htab_elem_get_ptr(l, map->key_size);
 			for_each_possible_cpu(cpu) {
-				bpf_long_memcpy(dst_val + off,
-						per_cpu_ptr(pptr, cpu), size);
+				copy_map_value_long(&htab->map, dst_val + off, per_cpu_ptr(pptr, cpu));
+				check_and_init_map_value(&htab->map, dst_val + off);
 				off += size;
 			}
 		} else {
@@ -2031,9 +2049,9 @@ static int __bpf_hash_map_seq_show(struct seq_file *seq, struct htab_elem *elem)
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
@@ -2277,8 +2295,8 @@ int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value)
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
index 723699263a62..3214bab5b462 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1045,7 +1045,9 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 			goto free_map_tab;
 		}
 		if (map->map_type != BPF_MAP_TYPE_HASH &&
+		    map->map_type != BPF_MAP_TYPE_PERCPU_HASH &&
 		    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
+		    map->map_type != BPF_MAP_TYPE_LRU_PERCPU_HASH &&
 		    map->map_type != BPF_MAP_TYPE_ARRAY &&
 		    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) {
 			ret = -EOPNOTSUPP;
-- 
2.34.1

