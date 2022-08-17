Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B81759789C
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 23:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242264AbiHQVEz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 17:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242293AbiHQVEo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 17:04:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8558AB063
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:04:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso2186083pjj.4
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KAWNhWE/WD3wFZacJ2ko17zYo7gsMhvffUTmRG8how0=;
        b=NCslPlVANCcPFLe+NudeKJp3stSLbLNvDlVM4l6GRW31jEQunqYdwUeqVpyAZFEYUd
         Nsu90E90NAi+jruawjTmW3iszTS5o4+/oQRXA+EAYmMH6gMH+q6E4XaK9xCNoOE/Jlfi
         AtFH6utAhWuBPc8K5UIr4v/+SdWR+9gVFb9k9dah8dOC4wlzYCNQU1w10aLDysfso3Zz
         pT2KEyJ5Uydtip79+Zy/PgCOlmSEbMzk/b50NFLGvcFgLJ6P9DNzLuCqIeOgFtNkMbJ5
         +iWKmUjxGcydPI+jGNj0PGqdzIaNM/TBGgRdACzDXrjY8dHbtYTnOzUPMA7WxV+Xzp5u
         E+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KAWNhWE/WD3wFZacJ2ko17zYo7gsMhvffUTmRG8how0=;
        b=FSPYRO0bnltLCBkR5rAoF28+MjWLbrj8LRvhg71ZQN8OW36EwwE455/Uyltp5K6v6Q
         sFT0aFz+f0wIj6mfze4w7LOmT33UB3NFb8LwY5yhWvyevZqAtjt2m8qlSIwhdRaGqvH+
         xPdBjsSasAY3nEMQrmqabiuiJf1fWyHFCC6dMAj4+5PsxfYj/RG0a12q7GJNm4W+IyMe
         ygVMA1R62yCB8Wj2IWLTmw7H7PYniiHkArHMAoFqT/nXpKkei9NMjdrIpka3xw0lQQ5S
         zp5hc/5ERHcDRyGmRnyeZkeKEC5V7UQdHvQk3QrUNjmwF1WCUMPcweA17JbC9Ole+RvA
         VBkQ==
X-Gm-Message-State: ACgBeo2T+X+Unj2GA3D+rQjoSw4135mIrN6D2848ncY6a01/l3FaDogj
        9pJUy0DJnZJRz4W4Ktou5A0=
X-Google-Smtp-Source: AA6agR74GmAwlmZZ2NQTJ2UBJaLITzOqdg5eTHBAJveQj8+xB4gEduTC/HaURwto3/n38jvd/RaQ8g==
X-Received: by 2002:a17:90b:1c0d:b0:1f5:7bda:1447 with SMTP id oc13-20020a17090b1c0d00b001f57bda1447mr5407863pjb.88.1660770281180;
        Wed, 17 Aug 2022 14:04:41 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:ccd6])
        by smtp.gmail.com with ESMTPSA id b189-20020a62cfc6000000b0052d1275a570sm10913598pfg.64.2022.08.17.14.04.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Aug 2022 14:04:40 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 05/12] bpf: Relax the requirement to use preallocated hash maps in tracing progs.
Date:   Wed, 17 Aug 2022 14:04:12 -0700
Message-Id: <20220817210419.95560-6-alexei.starovoitov@gmail.com>
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

Since bpf hash map was converted to use bpf_mem_alloc it is safe to use
from tracing programs and in RT kernels.
But per-cpu hash map is still using dynamic allocation for per-cpu map
values, hence keep the warning for this map type.
In the future alloc_percpu_gfp can be front-end-ed with bpf_mem_cache
and this restriction will be completely lifted.
perf_event (NMI) bpf programs have to use preallocated hash maps,
because free_htab_elem() is using call_rcu which might crash if re-entered.

Sleepable bpf programs have to use preallocated hash maps, because
life time of the map elements is not protected by rcu_read_lock/unlock.
This restriction can be lifted in the future as well.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2c1f8069f7b7..d785f29047d7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12605,10 +12605,12 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 	 * For programs attached to PERF events this is mandatory as the
 	 * perf NMI can hit any arbitrary code sequence.
 	 *
-	 * All other trace types using preallocated hash maps are unsafe as
-	 * well because tracepoint or kprobes can be inside locked regions
-	 * of the memory allocator or at a place where a recursion into the
-	 * memory allocator would see inconsistent state.
+	 * All other trace types using non-preallocated per-cpu hash maps are
+	 * unsafe as well because tracepoint or kprobes can be inside locked
+	 * regions of the per-cpu memory allocator or at a place where a
+	 * recursion into the per-cpu memory allocator would see inconsistent
+	 * state. Non per-cpu hash maps are using bpf_mem_alloc-tor which is
+	 * safe to use from kprobe/fentry and in RT.
 	 *
 	 * On RT enabled kernels run-time allocation of all trace type
 	 * programs is strictly prohibited due to lock type constraints. On
@@ -12618,15 +12620,26 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 	 */
 	if (is_tracing_prog_type(prog_type) && !is_preallocated_map(map)) {
 		if (prog_type == BPF_PROG_TYPE_PERF_EVENT) {
+			/* perf_event bpf progs have to use preallocated hash maps
+			 * because non-prealloc is still relying on call_rcu to free
+			 * elements.
+			 */
 			verbose(env, "perf_event programs can only use preallocated hash map\n");
 			return -EINVAL;
 		}
-		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-			verbose(env, "trace type programs can only use preallocated hash map\n");
-			return -EINVAL;
+		if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
+		    (map->inner_map_meta &&
+		     map->inner_map_meta->map_type == BPF_MAP_TYPE_PERCPU_HASH)) {
+			if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+				verbose(env,
+					"trace type programs can only use preallocated per-cpu hash map\n");
+				return -EINVAL;
+			}
+			WARN_ONCE(1, "trace type BPF program uses run-time allocation\n");
+			verbose(env,
+				"trace type programs with run-time allocated per-cpu hash maps are unsafe."
+				" Switch to preallocated hash maps.\n");
 		}
-		WARN_ONCE(1, "trace type BPF program uses run-time allocation\n");
-		verbose(env, "trace type programs with run-time allocated hash maps are unsafe. Switch to preallocated hash maps.\n");
 	}
 
 	if (map_value_has_spin_lock(map)) {
-- 
2.30.2

