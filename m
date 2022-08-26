Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10735A1F09
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 04:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244855AbiHZCow (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 22:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244841AbiHZCov (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 22:44:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F73A1F2D4
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:44:50 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 142so302861pfu.10
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=OsoTVXPQ6+PDC/ic9azQGTBktlzZtn9DYA063dTVrZc=;
        b=luqFTwYi12weGzQ+UoeVPQSf1nhScJ0NkKyeKThJurowbjiXXy0lv7aSHQe1cfmt1P
         xsFeT3FWfP1wL7fse38yym5SfqWIyh4hvNqR87ivgRfx/grhUyjD0ldYpBZlAlW7WhtZ
         r2+NMugZ/qMUoim6eLe2te13jAU5IfUIQS4Y+2NtU9S6Wz8NunrN4afxGSOrBeKppwmH
         JNU9jyU/KITi1nu7v6ub/xagl13MF8SkYPfqBpdy5+8lJ0COEAHPg2RZMVZXYkWhV/EE
         zyJl+J0sg+2B70hPvRh9od7DUku2fa69Kr3RJlHmJ0q/Q+yc8K5AGeqMNgQc6alRUODH
         47Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=OsoTVXPQ6+PDC/ic9azQGTBktlzZtn9DYA063dTVrZc=;
        b=S1CU9dk2gkv92At1nFj5mcAEU25k0f14d5otJamkgWPkjz8y1QCfLhwy44ok08nMUc
         x5gM7XdIwMatlo+MCKT5pEQS2PvH+WUgEhi61NtIYS22o+p3mkJ5WrYLJgyQ2xiJBErg
         wqyv4qd6QBHdU3mIftyqNOcEsqs50En/WjB2hb4Ce9RjQqjI8Zj9VLcZvHVcu5wSMsZs
         3wHZa/UeB0hSGBdwrqb5+RcXLCcwziBx4n8wQVPBjd/vHSMf+Cg7/aoj0pmJkZAWNuMe
         7MDJfca1MZOvEZRiawv+2v4HDoaZAI4PyHwJEYYAcVgt5E+s2vM7zs6fJ4GXRpM5qUfr
         v8WA==
X-Gm-Message-State: ACgBeo0wWzzWHtXY/VoDt7mtXDrYaLympKLise/JmXIaeD56Bixx8L0M
        bHMlcIZVMGgNi7hhaEJTz4FhURypHf4=
X-Google-Smtp-Source: AA6agR6kavHPljuwulMUHsrGVJHdEQX4+1VJhqZ3+3NTWH7ASxAm2WjdfuseM2tmAtrAW00wL8lWGg==
X-Received: by 2002:a63:ff09:0:b0:42a:59ee:1775 with SMTP id k9-20020a63ff09000000b0042a59ee1775mr1563462pgi.85.1661481889744;
        Thu, 25 Aug 2022 19:44:49 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:15dc])
        by smtp.gmail.com with ESMTPSA id b5-20020a656685000000b00429c5270710sm312596pgw.1.2022.08.25.19.44.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Aug 2022 19:44:49 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 04/15] samples/bpf: Reduce syscall overhead in map_perf_test.
Date:   Thu, 25 Aug 2022 19:44:19 -0700
Message-Id: <20220826024430.84565-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
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

