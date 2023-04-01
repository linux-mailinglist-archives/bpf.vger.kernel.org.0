Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA286D2FA3
	for <lists+bpf@lfdr.de>; Sat,  1 Apr 2023 12:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjDAKK3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Apr 2023 06:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjDAKK2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Apr 2023 06:10:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4650821AB8
        for <bpf@vger.kernel.org>; Sat,  1 Apr 2023 03:10:26 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso15334485wmo.0
        for <bpf@vger.kernel.org>; Sat, 01 Apr 2023 03:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680343824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yx0hUonKOCJvsiUNCX2Mck76mSOuFa1YQc/x2HBheZA=;
        b=Dkp7MRTDtyCKlvKMHvAxZjw6mc9yXXprCfs6MNm0FwBuqnQX4733R8v/eVvo3yCqMG
         T2sN+tJtshSV4fViLhzvKiabirkHl/WIpCpf0C2/B4lMVQfGA/GZ5UYhP6f6VO0+di/I
         4HRRvm78N3UTmM1npZNKhWNfYkGBCIzcCsSuVwdarcJBEvg3CbJs+Q/BqzfuMCsrT+j9
         uX1Du/H60U4u1DDmMmc2MHmweuKvatFf4uqq9OY5OhSkBRy1LYzfHvI3s7Uj6h6wKRmO
         WJobqvD09+mMMwM7gcpj0NaS0Eas5t9qH7IoubzQiOzIChI0fJahq2vTIlFw0kHWPhCz
         K4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680343824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yx0hUonKOCJvsiUNCX2Mck76mSOuFa1YQc/x2HBheZA=;
        b=3UvV9wfrYM0lMCXGK83kAY+6dgXAZqnc6s4vRm7wgFB7fnVUiKArd3rxsrtx+72x05
         N8aXICNCkgOFAQMFcVWhdUYY4eHIHKkd64PojrdcM20yNkaZouJhwM1zeF6+dAi5zKMC
         Jqm/aFwI6k7Poj+87tOBJmyknyUs1xM/L2ZJEsmwrZfG/acyvGMIq74DS8VtLFMrNzHb
         /0qovhv9AgaLFda1I6ohydpWIX7ulDyQgJTAIUkqqZpqJ2EI4ItAPKQYfmHVAgNsgpQw
         89RcirrYErEP89pDG1b95zJ/CaB1gkG4jAERQ84jiYxMiorTxrpsWv3Rvi0bOhGZt3kn
         OGIg==
X-Gm-Message-State: AAQBX9cZbtyljaS1jriAuYYP52+aZ1ppCOEwIwHTJbH8a89z2vQMBT1l
        1Kgc9SKQUJecNr99sgag/PV+gYxyNCJxAw8tncyW2w==
X-Google-Smtp-Source: AKy350bnFvUR7Npx+ch5FmAZ7qfBQxDCUulXidN6zgYaCqyKaFR3DUnDP8mXDqfWMmCSPsmKWyFixw==
X-Received: by 2002:a7b:c3d1:0:b0:3ef:61f6:d7c4 with SMTP id t17-20020a7bc3d1000000b003ef61f6d7c4mr18897506wmj.18.1680343824325;
        Sat, 01 Apr 2023 03:10:24 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id m26-20020a05600c3b1a00b003ede2c4701dsm12804697wms.14.2023.04.01.03.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 03:10:23 -0700 (PDT)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next] bpf: optimize hashmap lookups when key_size is divisible by 4
Date:   Sat,  1 Apr 2023 10:10:50 +0000
Message-Id: <20230401101050.358342-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The BPF hashmap uses the jhash() hash function. There is an optimized version
of this hash function which may be used if hash size is a multiple of 4. Apply
this optimization to the hashmap in a similar way as it is done in the bloom
filter map.

On practice the optimization is only noticeable for smaller key sizes, which,
however, is sufficient for many applications. An example is listed in the
following table of measurements (a hashmap of 65536 elements was used):

    --------------------------------------------------------------------
    | key_size | fullness | lookups /sec | lookups (opt) /sec |   gain |
    --------------------------------------------------------------------
    |        4 |      25% |      42.990M |            46.000M |   7.0% |
    |        4 |      50% |      37.910M |            39.094M |   3.1% |
    |        4 |      75% |      34.486M |            36.124M |   4.7% |
    |        4 |     100% |      31.760M |            32.719M |   3.0% |
    --------------------------------------------------------------------
    |        8 |      25% |      43.855M |            49.626M |  13.2% |
    |        8 |      50% |      38.328M |            42.152M |  10.0% |
    |        8 |      75% |      34.483M |            38.088M |  10.5% |
    |        8 |     100% |      31.306M |            34.686M |  10.8% |
    --------------------------------------------------------------------
    |       12 |      25% |      38.398M |            43.770M |  14.0% |
    |       12 |      50% |      33.336M |            37.712M |  13.1% |
    |       12 |      75% |      29.917M |            34.440M |  15.1% |
    |       12 |     100% |      27.322M |            30.480M |  11.6% |
    --------------------------------------------------------------------
    |       16 |      25% |      41.491M |            41.921M |   1.0% |
    |       16 |      50% |      36.206M |            36.474M |   0.7% |
    |       16 |      75% |      32.529M |            33.027M |   1.5% |
    |       16 |     100% |      29.581M |            30.325M |   2.5% |
    --------------------------------------------------------------------
    |       20 |      25% |      34.240M |            36.787M |   7.4% |
    |       20 |      50% |      30.328M |            32.663M |   7.7% |
    |       20 |      75% |      27.536M |            29.354M |   6.6% |
    |       20 |     100% |      24.847M |            26.505M |   6.7% |
    --------------------------------------------------------------------
    |       24 |      25% |      36.329M |            40.608M |  11.8% |
    |       24 |      50% |      31.444M |            35.059M |  11.5% |
    |       24 |      75% |      28.426M |            31.452M |  10.6% |
    |       24 |     100% |      26.278M |            28.741M |   9.4% |
    --------------------------------------------------------------------
    |       28 |      25% |      31.540M |            31.944M |   1.3% |
    |       28 |      50% |      27.739M |            28.063M |   1.2% |
    |       28 |      75% |      24.993M |            25.814M |   3.3% |
    |       28 |     100% |      23.513M |            23.500M |  -0.1% |
    --------------------------------------------------------------------
    |       32 |      25% |      32.116M |            33.953M |   5.7% |
    |       32 |      50% |      28.879M |            29.859M |   3.4% |
    |       32 |      75% |      26.227M |            26.948M |   2.7% |
    |       32 |     100% |      23.829M |            24.613M |   3.3% |
    --------------------------------------------------------------------
    |       64 |      25% |      22.535M |            22.554M |   0.1% |
    |       64 |      50% |      20.471M |            20.675M |   1.0% |
    |       64 |      75% |      19.077M |            19.146M |   0.4% |
    |       64 |     100% |      17.710M |            18.131M |   2.4% |
    --------------------------------------------------------------------

The following script was used to gather the results (SMT & frequency off):

    cd tools/testing/selftests/bpf
    for key_size in 4 8 12 16 20 24 28 32 64; do
            for nr_entries in `seq 16384 16384 65536`; do
                    fullness=$(printf '%3s' $((nr_entries*100/65536)))
                    echo -n "key_size=$key_size: $fullness% full: "
                    sudo ./bench -d2 -a bpf-hashmap-lookup --key_size=$key_size --nr_entries=$nr_entries --max_entries=65536 --nr_loops=2000000 --map_flags=0x40 | grep cpu
            done
            echo
    done

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 kernel/bpf/hashtab.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 96b645bba3a4..eb804815f7c3 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -103,6 +103,7 @@ struct bpf_htab {
 	u32 n_buckets;	/* number of hash buckets */
 	u32 elem_size;	/* size of each element in bytes */
 	u32 hashrnd;
+	u32 key_size_u32;
 	struct lock_class_key lockdep_key;
 	int __percpu *map_locked[HASHTAB_MAP_LOCK_COUNT];
 };
@@ -510,6 +511,10 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	else
 		htab->elem_size += round_up(htab->map.value_size, 8);
 
+	/* optimize hash computations if key_size is divisible by 4 */
+	if ((attr->key_size & (sizeof(u32) - 1)) == 0)
+		htab->key_size_u32 = attr->key_size / sizeof(u32);
+
 	err = -E2BIG;
 	/* prevent zero size kmalloc and check for u32 overflow */
 	if (htab->n_buckets == 0 ||
@@ -605,9 +610,11 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	return ERR_PTR(err);
 }
 
-static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrnd)
+static inline u32 htab_map_hash(const struct bpf_htab *htab, const void *key, u32 key_len)
 {
-	return jhash(key, key_len, hashrnd);
+	if (likely(htab->key_size_u32))
+		return jhash2(key, htab->key_size_u32, htab->hashrnd);
+	return jhash(key, key_len, htab->hashrnd);
 }
 
 static inline struct bucket *__select_bucket(struct bpf_htab *htab, u32 hash)
@@ -673,7 +680,7 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
 
 	key_size = map->key_size;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = htab_map_hash(htab, key, key_size);
 
 	head = select_bucket(htab, hash);
 
@@ -832,7 +839,7 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 	if (!key)
 		goto find_first_elem;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = htab_map_hash(htab, key, key_size);
 
 	head = select_bucket(htab, hash);
 
@@ -1093,7 +1100,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 
 	key_size = map->key_size;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = htab_map_hash(htab, key, key_size);
 
 	b = __select_bucket(htab, hash);
 	head = &b->head;
@@ -1195,7 +1202,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 
 	key_size = map->key_size;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = htab_map_hash(htab, key, key_size);
 
 	b = __select_bucket(htab, hash);
 	head = &b->head;
@@ -1263,7 +1270,7 @@ static long __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 
 	key_size = map->key_size;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = htab_map_hash(htab, key, key_size);
 
 	b = __select_bucket(htab, hash);
 	head = &b->head;
@@ -1318,7 +1325,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 
 	key_size = map->key_size;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = htab_map_hash(htab, key, key_size);
 
 	b = __select_bucket(htab, hash);
 	head = &b->head;
@@ -1393,7 +1400,7 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 
 	key_size = map->key_size;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = htab_map_hash(htab, key, key_size);
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
@@ -1429,7 +1436,7 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 
 	key_size = map->key_size;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = htab_map_hash(htab, key, key_size);
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
@@ -1572,7 +1579,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 
 	key_size = map->key_size;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = htab_map_hash(htab, key, key_size);
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
-- 
2.34.1

