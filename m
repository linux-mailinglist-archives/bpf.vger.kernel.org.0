Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCA459A7F0
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 23:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiHSVnB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 17:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiHSVm7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 17:42:59 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B1810E7A9
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:42:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id f21so5788677pjt.2
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KAWNhWE/WD3wFZacJ2ko17zYo7gsMhvffUTmRG8how0=;
        b=IJU+tAgIT6VuO5vXWYEJYSrs+tbTdFc9scQFNl6/qxCoimGAqFqVKFLtfP3ORfpHRc
         pMymoiUer9FBhgdQ10onvBH5bPowq+J6JG09mUonw6k8A2ayOcFgskAwekWPRUCYgmss
         oztKP6p+IMe2wJNJifLQ68ZaYz7G53sojy2B5ky2v65akg2hOaUTmghTabkRHWQZvZna
         rGSAxzIyfaskEWfhv23ry3UX8LpgnOvXseZtfV+mehCvPNP2HJj144ese0DFSPJ3SrNy
         8xi+X6X9qUJEsq2kzUFxG5rysq8yLSOa4aIB+30GlKaNeGCMmvFIG9+8RQRgRCS4ypyd
         K2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KAWNhWE/WD3wFZacJ2ko17zYo7gsMhvffUTmRG8how0=;
        b=avGF0O6vn6hRGzAqbVIkIWBLni3LPHhsFIroziY0xCzA6NW37Ij5sQxXoEAK3jhLyz
         UkIhd4jsOpAfrNz5GjUnIT3vbA6PKqvl0YSsP2Uo4XcrESCUp7ITaANxBPDv9HiXqZ/q
         hp5xjEQ+qoTV3HlZ6T4Aud5NSDD/Vx9sajDQqTnh5EuxU0R/TIrIpuTEIqFnfAqp4FSc
         PGr8CVYDt5XnldCRE5DY2NAEHfQHcObYkLmjdfjRX/c6gZXm/K2A21IUO7eIK7M/YQS2
         g3x0ncX5f2y/GVjHj+7fNfRvh/TzcWpNDHgNHmBnB4Nn0AEUk2bCQfMqBrcCzy0boIPo
         avqw==
X-Gm-Message-State: ACgBeo1Y36KIAi/NNvhJo+feX4DSUSa7x/l2XVfJYIEypiQNirnTMPju
        ToPRvaTJXRkfAJvaLSObUKA=
X-Google-Smtp-Source: AA6agR5imW3PqoQL8w/K4SjG7gOYKgOg1fCub6mJHTYaUIK+t9YYvXW+AavS+6d/c4j5U1tijiMk3A==
X-Received: by 2002:a17:902:cf11:b0:172:6437:412e with SMTP id i17-20020a170902cf1100b001726437412emr9009830plg.77.1660945373647;
        Fri, 19 Aug 2022 14:42:53 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:c4b1])
        by smtp.gmail.com with ESMTPSA id c5-20020a637245000000b0041a919ed63dsm3341084pgn.3.2022.08.19.14.42.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Aug 2022 14:42:53 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 05/15] bpf: Relax the requirement to use preallocated hash maps in tracing progs.
Date:   Fri, 19 Aug 2022 14:42:22 -0700
Message-Id: <20220819214232.18784-6-alexei.starovoitov@gmail.com>
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

