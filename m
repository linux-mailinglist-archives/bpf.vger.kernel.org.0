Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43B25A9CCF
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 18:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiIAQQK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 12:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbiIAQQI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 12:16:08 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3005A13D40
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 09:16:07 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mj6so12569503pjb.1
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 09:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4+uhdcDVuSjjem7hAR91KRY20zQndt0vkR0L244Rk1E=;
        b=X3BQnN1FrgHzUYqVbVs1H1+mR0vvs5nam4bT9s2R8NmvUqCWS2jYL5Hx9tovemlNUC
         VtgRk9Ol9wZ+uMvlqWhA2hO5eBZwi0AEls2phiK4D87fd0bVR9SrCySTZCEsxGBHJt7h
         SToxP96pnw7JM5j/X6fgZEJl5BvcShX8/P5pLOX8eUeJZAB3IqKw8RPCQNsa6hKBkrYT
         xqYN+q2GHOo+hHKBst5IWxG+IsKjG0WrqQiYWu1Jwsf2lT3lD7t3WaxLL/1LK5Z/wRsA
         2k7wBm+OJ6UczjU3U9M88OdpcVPPcKxavFkS2bDSFlvh3U6yuUu6Tg+uNlmv7TBdrdqj
         aPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4+uhdcDVuSjjem7hAR91KRY20zQndt0vkR0L244Rk1E=;
        b=I0Z9sDJUfQN5cUc3qGRluqsKZsssBLc2CDbj3uggt9AXR//zZi2XNFGKMbx1ERYPrm
         lTZSIwLWEX8Ut5kjDW5pTq/2egEtHXN8+TwTjf9IK/SllpOdEpP+Qb3qoV1kALUKvxMg
         rZ/5spUblUVtJZ6xr5mEwKDVBQ/YkveGDUC+0gD1GKy3p1H7TYoyMgnEnBY6BLFeOTGd
         xOxwr+OKP6tszUUhhjEexZEhUcyNbEJIgbGpXfVnu0/qvHbh+snofh9I0flefywWP1m5
         Ea98hh0caqcRe5/ehehxjPZ6EX9O6MA0W1jg/fYNoVqVldL77HVwmO5H89v+zV5nM0Eh
         MRQw==
X-Gm-Message-State: ACgBeo1GUbJhPKU6B3NCXU4rnln+9RF4ylYOwFOYDxbvzGIoCPMDHtMp
        2NKJ66WSG7DU8oFzbttf0ys=
X-Google-Smtp-Source: AA6agR5gABxsJnibFAbtnZO6qA0vlV4mshES5C/WYy8Tev8VVQ5AolYNHCMJMYfMtawypsYBlFEzMg==
X-Received: by 2002:a17:90a:6001:b0:1fa:e851:3480 with SMTP id y1-20020a17090a600100b001fae8513480mr9452909pji.153.1662048966625;
        Thu, 01 Sep 2022 09:16:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::3:4dc5])
        by smtp.gmail.com with ESMTPSA id t2-20020a1709027fc200b001708e1a10a3sm14133494plb.94.2022.09.01.09.16.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Sep 2022 09:16:06 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 04/15] samples/bpf: Reduce syscall overhead in map_perf_test.
Date:   Thu,  1 Sep 2022 09:15:36 -0700
Message-Id: <20220901161547.57722-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901161547.57722-1-alexei.starovoitov@gmail.com>
References: <20220901161547.57722-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
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

From: Alexei Starovoitov <ast@kernel.org>

Make map_perf_test for preallocated and non-preallocated hash map
spend more time inside bpf program to focus performance analysis
on the speed of update/lookup/delete operations performed by bpf program.

It makes 'perf report' of bpf_mem_alloc look like:
 11.76%  map_perf_test    [k] _raw_spin_lock_irqsave
 11.26%  map_perf_test    [k] htab_map_update_elem
  9.70%  map_perf_test    [k] _raw_spin_lock
  9.47%  map_perf_test    [k] htab_map_delete_elem
  8.57%  map_perf_test    [k] memcpy_erms
  5.58%  map_perf_test    [k] alloc_htab_elem
  4.09%  map_perf_test    [k] __htab_map_lookup_elem
  3.44%  map_perf_test    [k] syscall_exit_to_user_mode
  3.13%  map_perf_test    [k] lookup_nulls_elem_raw
  3.05%  map_perf_test    [k] migrate_enable
  3.04%  map_perf_test    [k] memcmp
  2.67%  map_perf_test    [k] unit_free
  2.39%  map_perf_test    [k] lookup_elem_raw

Reduce default iteration count as well to make 'map_perf_test' quick enough
even on debug kernels.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 samples/bpf/map_perf_test_kern.c | 44 ++++++++++++++++++++------------
 samples/bpf/map_perf_test_user.c |  2 +-
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/samples/bpf/map_perf_test_kern.c b/samples/bpf/map_perf_test_kern.c
index 8773f22b6a98..7342c5b2f278 100644
--- a/samples/bpf/map_perf_test_kern.c
+++ b/samples/bpf/map_perf_test_kern.c
@@ -108,11 +108,14 @@ int stress_hmap(struct pt_regs *ctx)
 	u32 key = bpf_get_current_pid_tgid();
 	long init_val = 1;
 	long *value;
+	int i;
 
-	bpf_map_update_elem(&hash_map, &key, &init_val, BPF_ANY);
-	value = bpf_map_lookup_elem(&hash_map, &key);
-	if (value)
-		bpf_map_delete_elem(&hash_map, &key);
+	for (i = 0; i < 10; i++) {
+		bpf_map_update_elem(&hash_map, &key, &init_val, BPF_ANY);
+		value = bpf_map_lookup_elem(&hash_map, &key);
+		if (value)
+			bpf_map_delete_elem(&hash_map, &key);
+	}
 
 	return 0;
 }
@@ -123,11 +126,14 @@ int stress_percpu_hmap(struct pt_regs *ctx)
 	u32 key = bpf_get_current_pid_tgid();
 	long init_val = 1;
 	long *value;
+	int i;
 
-	bpf_map_update_elem(&percpu_hash_map, &key, &init_val, BPF_ANY);
-	value = bpf_map_lookup_elem(&percpu_hash_map, &key);
-	if (value)
-		bpf_map_delete_elem(&percpu_hash_map, &key);
+	for (i = 0; i < 10; i++) {
+		bpf_map_update_elem(&percpu_hash_map, &key, &init_val, BPF_ANY);
+		value = bpf_map_lookup_elem(&percpu_hash_map, &key);
+		if (value)
+			bpf_map_delete_elem(&percpu_hash_map, &key);
+	}
 	return 0;
 }
 
@@ -137,11 +143,14 @@ int stress_hmap_alloc(struct pt_regs *ctx)
 	u32 key = bpf_get_current_pid_tgid();
 	long init_val = 1;
 	long *value;
+	int i;
 
-	bpf_map_update_elem(&hash_map_alloc, &key, &init_val, BPF_ANY);
-	value = bpf_map_lookup_elem(&hash_map_alloc, &key);
-	if (value)
-		bpf_map_delete_elem(&hash_map_alloc, &key);
+	for (i = 0; i < 10; i++) {
+		bpf_map_update_elem(&hash_map_alloc, &key, &init_val, BPF_ANY);
+		value = bpf_map_lookup_elem(&hash_map_alloc, &key);
+		if (value)
+			bpf_map_delete_elem(&hash_map_alloc, &key);
+	}
 	return 0;
 }
 
@@ -151,11 +160,14 @@ int stress_percpu_hmap_alloc(struct pt_regs *ctx)
 	u32 key = bpf_get_current_pid_tgid();
 	long init_val = 1;
 	long *value;
+	int i;
 
-	bpf_map_update_elem(&percpu_hash_map_alloc, &key, &init_val, BPF_ANY);
-	value = bpf_map_lookup_elem(&percpu_hash_map_alloc, &key);
-	if (value)
-		bpf_map_delete_elem(&percpu_hash_map_alloc, &key);
+	for (i = 0; i < 10; i++) {
+		bpf_map_update_elem(&percpu_hash_map_alloc, &key, &init_val, BPF_ANY);
+		value = bpf_map_lookup_elem(&percpu_hash_map_alloc, &key);
+		if (value)
+			bpf_map_delete_elem(&percpu_hash_map_alloc, &key);
+	}
 	return 0;
 }
 
diff --git a/samples/bpf/map_perf_test_user.c b/samples/bpf/map_perf_test_user.c
index b6fc174ab1f2..1bb53f4b29e1 100644
--- a/samples/bpf/map_perf_test_user.c
+++ b/samples/bpf/map_perf_test_user.c
@@ -72,7 +72,7 @@ static int test_flags = ~0;
 static uint32_t num_map_entries;
 static uint32_t inner_lru_hash_size;
 static int lru_hash_lookup_test_entries = 32;
-static uint32_t max_cnt = 1000000;
+static uint32_t max_cnt = 10000;
 
 static int check_test_flags(enum test_type t)
 {
-- 
2.30.2

