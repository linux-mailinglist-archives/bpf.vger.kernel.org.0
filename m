Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38485AB9E6
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 23:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiIBVLZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 17:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiIBVLV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 17:11:21 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A48D9D75
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 14:11:21 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id fa2so3139615pjb.2
        for <bpf@vger.kernel.org>; Fri, 02 Sep 2022 14:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=J/UPgVAZJ6tCW63aRjPvtUFbVFMqtQ38ez6bXN9pU3M=;
        b=Z+zmpFJC3ftrCUSPfzCV0Qc+2ob3WsvAPqeuvhBKoKbFt/pQFqV+BNYqLRgGlwMwcy
         qgablL6I2lFEiyqIJPeMGNIfFp1Y4/CFOQbq+7qELRgwOhBw4b+BBOG0cdUFBL/bVKA6
         l1407TD0ndNw/7Bdljc+ajdeoW28Qt1LrRS2SmJHx2mYoun3SJvjfsj2GyKP2bVpVB7i
         PkBUxOsdRi3GMkWd3moYkiUoP+O9pxQQ67cPYC0J1q0Y73cOhy/KxQNtAq3e3kWaFIoU
         IVSlUHtFLztYXZQdXnmTI+ecqcWsvDl2sqtgY4YnafwdeW7UpsJ7wModLPgvD7hvkbVq
         7CfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=J/UPgVAZJ6tCW63aRjPvtUFbVFMqtQ38ez6bXN9pU3M=;
        b=h7E8W3bc5jxSUuwBhMJVpRmCLx2fwOuX4QrCrCUzGhZhTl4qHrxwZT7QR3hG8tSxkV
         YLSg4MWiF18VAjhEwb2IIxcsCUyoNWHxJys/4Y+d+659OB9DnsCQBH4rWz3Mg5IXJ79i
         ECDQqqW9T6yIGP+TfsPL/ZXYo0bJIR5cCt/a4snGsTMQfjSsApkf2IMej9d5MCc3Z5EI
         7HZdi8cb8XBm2N+zYx4L/8I8tx6oWwzpDz7bHHIJMYF2sKhvdd4XoyRt1R+6K+DudDke
         Xf8PaUT4jASuyXfRb4TKgoFawreC/AgYvlXK9+yBOr7NqvzayJhrfhs/9zSCyHl6I0+F
         5sTA==
X-Gm-Message-State: ACgBeo0sBTtd0OpPKN8Xse2v++k90mOiqEfhhOs3n1/TI4RGP+I0YoPh
        ttQBdA54rm8t+JvZqtYAfZo=
X-Google-Smtp-Source: AA6agR5fBaKqR/HFJSACOnkb0zESuppM0ekv4TN56bEZPQPXqUAgu74uIojKJ1YoGpyBynonlgp1Sw==
X-Received: by 2002:a17:90a:c402:b0:1f8:c335:d4d7 with SMTP id i2-20020a17090ac40200b001f8c335d4d7mr6953680pjt.242.1662153080473;
        Fri, 02 Sep 2022 14:11:20 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::c978])
        by smtp.gmail.com with ESMTPSA id h16-20020a170902f55000b0017532e01e3fsm2108917plf.276.2022.09.02.14.11.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Sep 2022 14:11:20 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 05/16] bpf: Relax the requirement to use preallocated hash maps in tracing progs.
Date:   Fri,  2 Sep 2022 14:10:47 -0700
Message-Id: <20220902211058.60789-6-alexei.starovoitov@gmail.com>
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

