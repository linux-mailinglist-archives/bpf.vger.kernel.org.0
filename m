Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B836556F79
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 02:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351013AbiFWAcv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 20:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245202AbiFWAcv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 20:32:51 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7801D41635
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 17:32:50 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y6so16791438plg.0
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 17:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hINQ/yHfHd8fEcG2GvNFV4wbT1UEVwTut/D2io8x27E=;
        b=aZL/BW+jGtcjIHjCl7AO1q13jaC1ToE4efM9IgZIpt85g2hO2a3Asjl49WHQ0lGb1n
         zw1NTf78iAOhOpnfe/8TtT+mWla9vb/vLMdgZXJta1lHZxbkwrw/9KZG4blsGC5iaGtT
         QuEZGXm140ZEMuU1pzbeXXMjE52TWpQ6z1DPzLUicpIKHSY2HO4pe29u9n6HRytwsQS5
         JT8UbdfKskXmECsiH5fUfB5UNBlbGKPDZ2ClTeFxke37YSjO269wptkvjyHKp983ETdi
         Dboq2B6+lMiPOJdeQbN9njEyfeYd08bnyaqnuYfHb0ZNk/qY9LXbMwSBdAGC0hrwad6Q
         UAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hINQ/yHfHd8fEcG2GvNFV4wbT1UEVwTut/D2io8x27E=;
        b=fv/JgDpZ5EIxJIQKcJTHbWaDT8ZCFsVwQ2ZInWcYw0cvm8FwNRsmKL+9TEVrk97FlX
         yZQ+WMPR2YuOk7g3r9OxsMtlnYysqT0kQkaX6zmv0JF4WZAWuwmcpUN9NIIwMBboG5LK
         bK7lJ8+w/99RjW3zMUKHPk6kLXAhLE66PtdNumRxmC8NS+K2VOwu2VS5iiH6FRVXNzRX
         fhynewhTTWePhtIDGPDyeROuvFJv3iRkl9lUU06zaG6mmtM7FsffeKBpGcg8G36dQYZr
         3L6xLxzwpsvPFVO9KiiJ3g0AXU0EGBBf1E9uraTaDiNNf1GLCighInBKWrihU6PpWAzT
         vBhA==
X-Gm-Message-State: AJIora+98qHtuTQzHFPXOvhr7PiQOmSSrvWd9fx4k+p4FQmMkI/t1e+N
        DK9LVfmk0CZHCVejo99kOLw=
X-Google-Smtp-Source: AGRyM1vF5n6k5yd8it0PIFmuxNUMmL64pcFcWXmUGEIGH72f2D5RFekUTbj8+u3ej6uH1od8cNIaYQ==
X-Received: by 2002:a17:90b:17cb:b0:1ec:9d52:46f7 with SMTP id me11-20020a17090b17cb00b001ec9d5246f7mr1058082pjb.221.1655944369920;
        Wed, 22 Jun 2022 17:32:49 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:29cb])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902e14c00b001624dab05edsm11216447pla.8.2022.06.22.17.32.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jun 2022 17:32:49 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        kafai@fb.com, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 4/5] samples/bpf: Reduce syscall overhead in map_perf_test.
Date:   Wed, 22 Jun 2022 17:32:29 -0700
Message-Id: <20220623003230.37497-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
References: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
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

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 samples/bpf/map_perf_test_kern.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/samples/bpf/map_perf_test_kern.c b/samples/bpf/map_perf_test_kern.c
index 8773f22b6a98..d5af4df9d403 100644
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
+	for (i = 0; i < 30; i++) {
+		bpf_map_update_elem(&hash_map, &key, &init_val, BPF_ANY);
+		value = bpf_map_lookup_elem(&hash_map, &key);
+		if (value)
+			bpf_map_delete_elem(&hash_map, &key);
+	}
 
 	return 0;
 }
@@ -137,11 +140,14 @@ int stress_hmap_alloc(struct pt_regs *ctx)
 	u32 key = bpf_get_current_pid_tgid();
 	long init_val = 1;
 	long *value;
+	int i;
 
-	bpf_map_update_elem(&hash_map_alloc, &key, &init_val, BPF_ANY);
-	value = bpf_map_lookup_elem(&hash_map_alloc, &key);
-	if (value)
-		bpf_map_delete_elem(&hash_map_alloc, &key);
+	for (i = 0; i < 30; i++) {
+		bpf_map_update_elem(&hash_map_alloc, &key, &init_val, BPF_ANY);
+		value = bpf_map_lookup_elem(&hash_map_alloc, &key);
+		if (value)
+			bpf_map_delete_elem(&hash_map_alloc, &key);
+	}
 	return 0;
 }
 
-- 
2.30.2

