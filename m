Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955BF5978AC
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 23:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242286AbiHQVEt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 17:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242287AbiHQVEm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 17:04:42 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B7EABD7A
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:04:38 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id h28so13039191pfq.11
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Y2Iep7E/2mTKKhtTknM/1Uwo/WL5pQSofmmMCSYQizM=;
        b=l511t2TjU9cNTBOx9nOJrQ6ETMhdEVpE34sc520kV4U+jZ5f1/mHDo0n9OekUckOKy
         du4HTtixwqbakopIP6DPt7uHyoakZjMbBFFYI2P6BgAezDFSgDnjzXkuF/HgbF4bXKrQ
         lXjZ2nN+GZMcztKh2LTcO0PENhud63SE9DLHss4fMDYrSDj+rRyftMt0+O6i9+MtgVZd
         Ygtrzto0rVVXWoQZsLipuFrePxZasxuS8/DFwMdD/qvZ7BPB3uAaYRUWnJZxw12ohn9n
         9NJ/1olkJ8lCRS/0zQtacyESI++6VurdVTijINkcRMVs3BDS81X+4ZQ6u/jYBhfY1WFW
         uvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Y2Iep7E/2mTKKhtTknM/1Uwo/WL5pQSofmmMCSYQizM=;
        b=2Fk2H3C/KM8OoLFZI3wQ301qx2jlOLaeH1oPrNSywuHkzqPQNADxS+Q1L9Z+5b5biX
         gONfp2tYIWJaSAuabsrv96YzdfPbj0q6EfjwH2jASKepXGEFbEBmsE45q82PfTbjNQtp
         dKaPncqp4vdIFNGhFU76xUHyk50hjgj8PlZClj/RDzpBsIQIvCNw+X8WbDjiNRCojgaN
         UDBClmpjZMUhwBFfYDXl6wvW+N7o0lzvLb6hMC9r46fcevUgFFe6Emq5m0XxzARYy9sU
         LlFZTfxSBsCCID/cL/BLFTzWnRk/AJXh4KTMX8GePWsKk089fnCPBpako5ny1JJ1z9fK
         SpzQ==
X-Gm-Message-State: ACgBeo2OSCadbTJXfQRJcs9Yb3uApGglkc6nozXbJz5icuOS1EPitmpZ
        Bx+UoX5kEaWKCsic4pEzenY=
X-Google-Smtp-Source: AA6agR45GVBnh/AwT6HQavfsDbI0KSDhUWRxLAFnLHiMWYdzeBKVe1kvgvJtDJgwHUoWoAjHWT8J1g==
X-Received: by 2002:a63:54c:0:b0:429:ee05:92 with SMTP id 73-20020a63054c000000b00429ee050092mr28661pgf.587.1660770277392;
        Wed, 17 Aug 2022 14:04:37 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:ccd6])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090301cf00b0016e8178aa9csm346372plh.210.2022.08.17.14.04.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Aug 2022 14:04:36 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 04/12] samples/bpf: Reduce syscall overhead in map_perf_test.
Date:   Wed, 17 Aug 2022 14:04:11 -0700
Message-Id: <20220817210419.95560-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220817210419.95560-1-alexei.starovoitov@gmail.com>
References: <20220817210419.95560-1-alexei.starovoitov@gmail.com>
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

