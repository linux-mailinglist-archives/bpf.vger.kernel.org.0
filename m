Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353E0617513
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 04:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiKCDfl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 23:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiKCDfk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 23:35:40 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061501409A
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 20:35:39 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id 13so2056533ejn.3
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 20:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqQvf1y9ry5dvTIyPG7bMobK5hjFONKYKNK206vAGDk=;
        b=jhLY6vBTm3WkLa2LgA5teWrG1D/VQJbaq5GLzhzipAPZN1oxUhB80DPqz5FsCMNCUy
         DnaVq25TSVLzsIBtdXIWVMcsbs98ybdTRGeCHpnYQ5mPYZmtPZXRkf9RC0muIE0Xk44Q
         NGT4iezqt4oopGhzfNboPWfVDBp/Q/R+GfWAovkjExFdBbXCKEouKkp8UbPkycgkXw+y
         XoZYeQUtpYaRuaAsBagHUyxQmRD+8nfteqTwPdq/bDtCOykjAiCIDIxoxyEtTGt1k7Nw
         o5yG5Y1j+78Fw1HvfyeYC7/6Xzhayl+T+Ifv0KslDhCrqU97RBeDbdkurWUaBcGKlqnZ
         yFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqQvf1y9ry5dvTIyPG7bMobK5hjFONKYKNK206vAGDk=;
        b=VztJPAU0GS5TedrwdnFoVuEIOTwraSpfM5DkYYbdFYLrT0y6w9xdoxMvyJSHHi+aL0
         SDo1QcKNEU3rAWmwGDxnlgQ38z5pZoBNMFMdtiFfw2+CUJdUcOwPV1cf6JhSvEIVbFom
         DZXnxUvYA3gLczpXwOcPSUSiKySjXd7E9g0FV73FWLcdU1C1avkQXHhG7UFYZegQ/ETr
         A5X/cj7KKwxVu2gTtYui7HuXP4/5cqahjfptlDDW2cuGqUpFH6Oi/mfrbR4xkJmfnulp
         7sYu5zP9oDE0G822mhDiT0oF3snOp1k/2zsQJPNMVHlWGBG2IcbrINnEsGCUXlhpG/YW
         NyNA==
X-Gm-Message-State: ACrzQf3Oyu9CnNyTE4LLzrvNyqA3Tp1W8xkAoZ1vgnB2uX+v8MSzBgj7
        q/5eMbi2inVXiagnzphF2T9P2ahBwEEs4dNX
X-Google-Smtp-Source: AMsMyM4SlgRmNhHVVDFwt635ZKNL1/uZdYdvsl0aK6GM1P07gUcw2/0JCjuatpKSlv76du4AiNkSZA==
X-Received: by 2002:a17:906:6a8d:b0:741:6a3b:536e with SMTP id p13-20020a1709066a8d00b007416a3b536emr27408575ejr.11.1667446537296;
        Wed, 02 Nov 2022 20:35:37 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b007815ca7ae57sm6106441eja.212.2022.11.02.20.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 20:35:37 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, alan.maguire@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: hashmap test cases updated for uintptr_t -> uintptr_t interface
Date:   Thu,  3 Nov 2022 05:34:28 +0200
Message-Id: <20221103033430.2611623-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103033430.2611623-1-eddyz87@gmail.com>
References: <20221103033430.2611623-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hashmap test cases require update after libbpf's hashmap interface
update from void* -> void* to uintptr_t -> uintptr_t. No logical
changes, types / casts updated to satisfy the type checker.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/hashmap.c        | 68 +++++++++----------
 .../bpf/prog_tests/kprobe_multi_test.c        |  6 +-
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/hashmap.c b/tools/testing/selftests/bpf/prog_tests/hashmap.c
index 4747ab18f97f..dd705959f91d 100644
--- a/tools/testing/selftests/bpf/prog_tests/hashmap.c
+++ b/tools/testing/selftests/bpf/prog_tests/hashmap.c
@@ -10,14 +10,14 @@
 
 static int duration = 0;
 
-static size_t hash_fn(const void *k, void *ctx)
+static size_t hash_fn(uintptr_t k, void *ctx)
 {
-	return (long)k;
+	return k;
 }
 
-static bool equal_fn(const void *a, const void *b, void *ctx)
+static bool equal_fn(uintptr_t a, uintptr_t b, void *ctx)
 {
-	return (long)a == (long)b;
+	return a == b;
 }
 
 static inline size_t next_pow_2(size_t n)
@@ -52,8 +52,8 @@ static void test_hashmap_generic(void)
 		return;
 
 	for (i = 0; i < ELEM_CNT; i++) {
-		const void *oldk, *k = (const void *)(long)i;
-		void *oldv, *v = (void *)(long)(1024 + i);
+		uintptr_t oldk, k = i;
+		uintptr_t oldv, v = 1024 + i;
 
 		err = hashmap__update(map, k, v, &oldk, &oldv);
 		if (CHECK(err != -ENOENT, "hashmap__update",
@@ -64,8 +64,8 @@ static void test_hashmap_generic(void)
 			err = hashmap__add(map, k, v);
 		} else {
 			err = hashmap__set(map, k, v, &oldk, &oldv);
-			if (CHECK(oldk != NULL || oldv != NULL, "check_kv",
-				  "unexpected k/v: %p=%p\n", oldk, oldv))
+			if (CHECK(oldk != 0 || oldv != 0, "check_kv",
+				  "unexpected k/v: %ld=%ld\n", (long)oldk, (long)oldv))
 				goto cleanup;
 		}
 
@@ -91,8 +91,8 @@ static void test_hashmap_generic(void)
 
 	found_msk = 0;
 	hashmap__for_each_entry(map, entry, bkt) {
-		long k = (long)entry->key;
-		long v = (long)entry->value;
+		long k = entry->key;
+		long v = entry->value;
 
 		found_msk |= 1ULL << k;
 		if (CHECK(v - k != 1024, "check_kv",
@@ -104,8 +104,8 @@ static void test_hashmap_generic(void)
 		goto cleanup;
 
 	for (i = 0; i < ELEM_CNT; i++) {
-		const void *oldk, *k = (const void *)(long)i;
-		void *oldv, *v = (void *)(long)(256 + i);
+		uintptr_t oldk, k = i;
+		uintptr_t oldv, v = 256 + i;
 
 		err = hashmap__add(map, k, v);
 		if (CHECK(err != -EEXIST, "hashmap__add",
@@ -139,8 +139,8 @@ static void test_hashmap_generic(void)
 
 	found_msk = 0;
 	hashmap__for_each_entry_safe(map, entry, tmp, bkt) {
-		long k = (long)entry->key;
-		long v = (long)entry->value;
+		long k = entry->key;
+		long v = entry->value;
 
 		found_msk |= 1ULL << k;
 		if (CHECK(v - k != 256, "elem_check",
@@ -152,7 +152,7 @@ static void test_hashmap_generic(void)
 		goto cleanup;
 
 	found_cnt = 0;
-	hashmap__for_each_key_entry(map, entry, (void *)0) {
+	hashmap__for_each_key_entry(map, entry, 0) {
 		found_cnt++;
 	}
 	if (CHECK(!found_cnt, "found_cnt",
@@ -161,9 +161,9 @@ static void test_hashmap_generic(void)
 
 	found_msk = 0;
 	found_cnt = 0;
-	hashmap__for_each_key_entry_safe(map, entry, tmp, (void *)0) {
-		const void *oldk, *k;
-		void *oldv, *v;
+	hashmap__for_each_key_entry_safe(map, entry, tmp, 0) {
+		uintptr_t oldk, k;
+		uintptr_t oldv, v;
 
 		k = entry->key;
 		v = entry->value;
@@ -198,8 +198,8 @@ static void test_hashmap_generic(void)
 		goto cleanup;
 
 	hashmap__for_each_entry_safe(map, entry, tmp, bkt) {
-		const void *oldk, *k;
-		void *oldv, *v;
+		uintptr_t oldk, k;
+		uintptr_t oldv, v;
 
 		k = entry->key;
 		v = entry->value;
@@ -235,7 +235,7 @@ static void test_hashmap_generic(void)
 	hashmap__for_each_entry(map, entry, bkt) {
 		CHECK(false, "elem_exists",
 		      "unexpected map entries left: %ld = %ld\n",
-		      (long)entry->key, (long)entry->value);
+		      entry->key, entry->value);
 		goto cleanup;
 	}
 
@@ -243,7 +243,7 @@ static void test_hashmap_generic(void)
 	hashmap__for_each_entry(map, entry, bkt) {
 		CHECK(false, "elem_exists",
 		      "unexpected map entries left: %ld = %ld\n",
-		      (long)entry->key, (long)entry->value);
+		      entry->key, entry->value);
 		goto cleanup;
 	}
 
@@ -251,14 +251,14 @@ static void test_hashmap_generic(void)
 	hashmap__free(map);
 }
 
-static size_t collision_hash_fn(const void *k, void *ctx)
+static size_t collision_hash_fn(uintptr_t k, void *ctx)
 {
 	return 0;
 }
 
 static void test_hashmap_multimap(void)
 {
-	void *k1 = (void *)0, *k2 = (void *)1;
+	uintptr_t k1 = 0, k2 = 1;
 	struct hashmap_entry *entry;
 	struct hashmap *map;
 	long found_msk;
@@ -273,23 +273,23 @@ static void test_hashmap_multimap(void)
 	 * [0] -> 1, 2, 4;
 	 * [1] -> 8, 16, 32;
 	 */
-	err = hashmap__append(map, k1, (void *)1);
+	err = hashmap__append(map, k1, 1);
 	if (CHECK(err, "elem_add", "failed to add k/v: %d\n", err))
 		goto cleanup;
-	err = hashmap__append(map, k1, (void *)2);
+	err = hashmap__append(map, k1, 2);
 	if (CHECK(err, "elem_add", "failed to add k/v: %d\n", err))
 		goto cleanup;
-	err = hashmap__append(map, k1, (void *)4);
+	err = hashmap__append(map, k1, 4);
 	if (CHECK(err, "elem_add", "failed to add k/v: %d\n", err))
 		goto cleanup;
 
-	err = hashmap__append(map, k2, (void *)8);
+	err = hashmap__append(map, k2, 8);
 	if (CHECK(err, "elem_add", "failed to add k/v: %d\n", err))
 		goto cleanup;
-	err = hashmap__append(map, k2, (void *)16);
+	err = hashmap__append(map, k2, 16);
 	if (CHECK(err, "elem_add", "failed to add k/v: %d\n", err))
 		goto cleanup;
-	err = hashmap__append(map, k2, (void *)32);
+	err = hashmap__append(map, k2, 32);
 	if (CHECK(err, "elem_add", "failed to add k/v: %d\n", err))
 		goto cleanup;
 
@@ -300,7 +300,7 @@ static void test_hashmap_multimap(void)
 	/* verify global iteration still works and sees all values */
 	found_msk = 0;
 	hashmap__for_each_entry(map, entry, bkt) {
-		found_msk |= (long)entry->value;
+		found_msk |= entry->value;
 	}
 	if (CHECK(found_msk != (1 << 6) - 1, "found_msk",
 		  "not all keys iterated: %lx\n", found_msk))
@@ -309,7 +309,7 @@ static void test_hashmap_multimap(void)
 	/* iterate values for key 1 */
 	found_msk = 0;
 	hashmap__for_each_key_entry(map, entry, k1) {
-		found_msk |= (long)entry->value;
+		found_msk |= entry->value;
 	}
 	if (CHECK(found_msk != (1 | 2 | 4), "found_msk",
 		  "invalid k1 values: %lx\n", found_msk))
@@ -318,7 +318,7 @@ static void test_hashmap_multimap(void)
 	/* iterate values for key 2 */
 	found_msk = 0;
 	hashmap__for_each_key_entry(map, entry, k2) {
-		found_msk |= (long)entry->value;
+		found_msk |= entry->value;
 	}
 	if (CHECK(found_msk != (8 | 16 | 32), "found_msk",
 		  "invalid k2 values: %lx\n", found_msk))
@@ -333,7 +333,7 @@ static void test_hashmap_empty()
 	struct hashmap_entry *entry;
 	int bkt;
 	struct hashmap *map;
-	void *k = (void *)0;
+	uintptr_t k = 0;
 
 	/* force collisions */
 	map = hashmap__new(hash_fn, equal_fn, NULL);
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 287b3ac40227..df26b4d714d5 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -312,12 +312,12 @@ static inline __u64 get_time_ns(void)
 	return (__u64) t.tv_sec * 1000000000 + t.tv_nsec;
 }
 
-static size_t symbol_hash(const void *key, void *ctx __maybe_unused)
+static size_t symbol_hash(uintptr_t key, void *ctx __maybe_unused)
 {
 	return str_hash((const char *) key);
 }
 
-static bool symbol_equal(const void *key1, const void *key2, void *ctx __maybe_unused)
+static bool symbol_equal(uintptr_t key1, uintptr_t key2, void *ctx __maybe_unused)
 {
 	return strcmp((const char *) key1, (const char *) key2) == 0;
 }
@@ -372,7 +372,7 @@ static int get_syms(char ***symsp, size_t *cntp)
 			     sizeof("__ftrace_invalid_address__") - 1))
 			continue;
 
-		err = hashmap__add(map, name, NULL);
+		err = hashmap__add(map, (uintptr_t)name, 0);
 		if (err == -EEXIST)
 			continue;
 		if (err)
-- 
2.34.1

