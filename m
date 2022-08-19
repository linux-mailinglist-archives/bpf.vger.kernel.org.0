Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3196959A7F1
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 23:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiHSVmw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 17:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiHSVmv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 17:42:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E06710DCD5
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:42:50 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id k14so5422967pfh.0
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Y2Iep7E/2mTKKhtTknM/1Uwo/WL5pQSofmmMCSYQizM=;
        b=gG+VWJ3awALvNnUdyC5xL/1f4A42VHpiPiDSlLBPml4whB/IXBE47qCA6VeA5GMhye
         kbelUgRgUkw8/z5A16+NaN7+dlsMj9i2VsZ6qd9GzI3d9CM7cz65arD4QIo1Q1EAaz3L
         NCbDlRtvO6uU5a6lznjnOSOsvc/+wEReO7RhQoh7W9hxRrDsq/U1DjtyR/1rbVREgA0b
         tHJCges6gxW8rHlU7QhGisbp54TXqJK0GSg6YHCvZrgXbhsMyq3SY676osQBPYfv9n/Q
         we1OuOyjcLdajD9JRo78l42/P0ojTBaTddHKBBYMDXwlHCwz2HyYFSg40kEOO23N2U4x
         D8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Y2Iep7E/2mTKKhtTknM/1Uwo/WL5pQSofmmMCSYQizM=;
        b=cJnvWqte0VH30+P3zdQYV+cwtm7vLZq5nIP620gTCpodvyj5IQsRJ/LMQ2nuQGd3n0
         2vHjnRGr5aI5U8jdQKrIV53jyWlElNOyYwDS+50+lvAyYHFz6PfmUAmTp8hcEwannuKd
         VmwxdK2Vs75J3CoP7aHXObo/4C1lF3CzUqZEX2C9ZVriWOpAgewghdAyclGFpEQlq4hM
         TSy1MJnojXTOK4NHSs2pECRcp/5l6/LcmYLcXK32hBMp5VLhnlC24tcQ4T0rLw0JlfEi
         mYgKQ2UwNgf83qbvIneHpI7Ax+ximxICWsuvIR+m+hqOqs+ctEgmkF+j+E2lrHCy4qCv
         Sjyw==
X-Gm-Message-State: ACgBeo30QJ2ityERHYqFHb+pBLzDzwZsSUg5nbSo55wWdLW0jrBkOl1E
        b/mxJvoWpP8jHw575ftsGHA=
X-Google-Smtp-Source: AA6agR4Iv3f5dhBPNPtyy0UsY3l+qHByiiKxabu+VXGaOrgGFuMa8I/iMKo4NKtrYYDovLnpxL3GMw==
X-Received: by 2002:a63:5b56:0:b0:422:6905:547f with SMTP id l22-20020a635b56000000b004226905547fmr7574031pgm.126.1660945370056;
        Fri, 19 Aug 2022 14:42:50 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:c4b1])
        by smtp.gmail.com with ESMTPSA id x61-20020a17090a6c4300b001f02a72f29csm3592368pjj.8.2022.08.19.14.42.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Aug 2022 14:42:49 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 04/15] samples/bpf: Reduce syscall overhead in map_perf_test.
Date:   Fri, 19 Aug 2022 14:42:21 -0700
Message-Id: <20220819214232.18784-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
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

