Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05585A9CD4
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 18:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiIAQQS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 12:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiIAQQP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 12:16:15 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC1D40BE6
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 09:16:12 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y29so13846451pfq.0
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 09:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=J/UPgVAZJ6tCW63aRjPvtUFbVFMqtQ38ez6bXN9pU3M=;
        b=IjJOZXlwXAdP31mjg7782uhU4/jcLGpev5FwbYyLhgz8B3Zyrk4J8mVjMSBWXWA4bI
         RrzZpEIwc0YP+o9onLWQaX5ooaOkQouh8CYdWyrvbzI+EMPUGTivQ5WkqlFhAODmhltO
         jgF8SWSqZeqj+a87lrKgwL7ZowGWROIsXchk69atLmOeiLLT8zne4zXYWaie77A5Wtc2
         Y481EEM1zTnfk0387pksfhRPshOc9invTfAvcs/p81XSnKJyNPXvy6Dszik+X3hI7DN9
         7Qr0fb9T91xvc5QFwMditIqFHhfJkvXDNi5dkEuHpmp0or4w2iLyXz/lQEDgEtjrreBR
         w6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=J/UPgVAZJ6tCW63aRjPvtUFbVFMqtQ38ez6bXN9pU3M=;
        b=1XWJcNJldJvwQG7QrAnD5x1yS0PpxVef9Z/ByWd5MMhzLuCC7W9VF81f7Xl1qXc/2M
         j30s6zoj+xPyZ0yXT64RgsfO63uy8K1xX4tleRfNPd1B68IHARcrJLCFrIW3GFtD/aty
         bs9VpIW6q8Qwc/34inGhE+6Dj5eX4fhPziUQ1Mv9ASiMg1hPFwP8mrLRZJd+i6lRsyhI
         UqShWx8l/RRMVcqaqsCsPsXScrboQ/i/thKHBXNXMHmeccL+u/CraErKqAiznWGAbRwM
         3Arg6TeuteghaKg1j4JWma2Rs1mv43X/HdroYFrhwwhi0nNVR0Sx7bSnBYBpXS0sm3gi
         vmlQ==
X-Gm-Message-State: ACgBeo29manQld7PhNJkHwuVNT8BKUAej6oaKRBWrd2ajPjGGLmO6Re9
        j7WC0SvEliSNo2Us8YgaORQ=
X-Google-Smtp-Source: AA6agR6tHH4CQrxuMQdew+YzVDFHkU2FlaZGbV8ylgjbpuxZs8+gpgFwqfa6KHB8piTEvus91KL2Ag==
X-Received: by 2002:a63:450f:0:b0:430:491e:ed5c with SMTP id s15-20020a63450f000000b00430491eed5cmr5762528pga.330.1662048970311;
        Thu, 01 Sep 2022 09:16:10 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::3:4dc5])
        by smtp.gmail.com with ESMTPSA id z16-20020aa79490000000b00538147b1a38sm9804924pfk.160.2022.09.01.09.16.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Sep 2022 09:16:09 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 05/15] bpf: Relax the requirement to use preallocated hash maps in tracing progs.
Date:   Thu,  1 Sep 2022 09:15:37 -0700
Message-Id: <20220901161547.57722-6-alexei.starovoitov@gmail.com>
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

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0194a36d0b36..3dce3166855f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12629,10 +12629,12 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
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
@@ -12642,15 +12644,26 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
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

