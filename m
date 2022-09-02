Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BF95AB9E4
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 23:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiIBVLT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 17:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiIBVLS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 17:11:18 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19FCD8E32
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 14:11:17 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id j5so3030232plj.5
        for <bpf@vger.kernel.org>; Fri, 02 Sep 2022 14:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4+uhdcDVuSjjem7hAR91KRY20zQndt0vkR0L244Rk1E=;
        b=E721puASI0KcWoJFMcQRS4f6jZ6+ghjyIowMzWFrGqRS6pgXqFl58dxkBEafFaLkKV
         CJixDExhy3mCCFK2DFTMUfBQjks9eFlG8cXISjtTYqjS0uBjtDfp/JvM3Q2/8fCO/Qg9
         jN72OKZLXtlsq4xJXOC+xXn2aMP5BqeSMhEZVSDazojdqfNJ/lySABQXrUbfcTjNKDWy
         +qC0qXQ9/Il3e6etrNaDeiXLpFYw/TF62fkiFIJTo4r8tKqya+s67YZ/ZMFGU24r3tkP
         J3AMy7qFsq/tblD8OojYdv6DHwFUDqyR+M0pXhgr8oM0yPbaHbLmvLN1Ke6LP41lghpW
         jBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4+uhdcDVuSjjem7hAR91KRY20zQndt0vkR0L244Rk1E=;
        b=1m0RRk+3jL8T9XR1vY8nHYcc5wIQqmq0/UJSF9ucOG0s221XUKNwxW4ny+UyZPnuNF
         pfR/a5+hTVbseHOWNjoeE2I9EMzHV3wRVJGYJhsMwxLcs8g8BX78yK7Q23WSkZHDHYV7
         cjdv6//LIZctkH+5hY8XJOUyM4fs+vZpfH3okFBnm1fjh/Yy+5utBwBogpEBIvzn+XJz
         2kHg1BwZkQhcNZ9jjku0MUhL5Ixa/3pBCrWbW8TcAtVOcu/mNZCIGHw3tS8bgnlFovgu
         0RxbIpmR6qRYdGAvYBAcVjWBAb4KLEhfoib6vAnkQHIvytaWKzo8RTUzwRwvsAf2yss+
         w7Bg==
X-Gm-Message-State: ACgBeo3ceUEFiB7EAh/6EKI2vF+QXfmUur1aKS8uFKGN67JcqZuHxASw
        qjfxBt5VgQtFtBOFAq0oqyQ=
X-Google-Smtp-Source: AA6agR6dWy255w61IoDpzzOIdj3C3jFRxBDgJPN2l719BRrtodChCNCvX7n9Ei0RsrYf0afyK9nbqg==
X-Received: by 2002:a17:90b:4f81:b0:1fe:1716:fe20 with SMTP id qe1-20020a17090b4f8100b001fe1716fe20mr6735459pjb.63.1662153076920;
        Fri, 02 Sep 2022 14:11:16 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::c978])
        by smtp.gmail.com with ESMTPSA id e7-20020a17090ab38700b001f1acb6c3ebsm1903023pjr.34.2022.09.02.14.11.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Sep 2022 14:11:16 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 04/16] samples/bpf: Reduce syscall overhead in map_perf_test.
Date:   Fri,  2 Sep 2022 14:10:46 -0700
Message-Id: <20220902211058.60789-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220902211058.60789-1-alexei.starovoitov@gmail.com>
References: <20220902211058.60789-1-alexei.starovoitov@gmail.com>
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

