Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C89556F7A
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 02:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359223AbiFWAc6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 20:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358574AbiFWAcz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 20:32:55 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7961124
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 17:32:54 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so992296pjj.5
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 17:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hireJk5IsliacX/pLET2ULAtcVeuHiddhIKbm7z+wFU=;
        b=fQECmFTOgP/m6aKXdsyg+p1Ubg3Vr3sG7vpfMmJwraTLKZo9C5ozVYkrj1HBau2OkI
         lYcnWh3GvzwjzbmVFTnZ/5e9lg3l7u/UkcdUMR0N58Sz0ej4XIIfVL09fALxaO4ctN8d
         wHvfnAmHu4LXYucvsPaVxLQdupNcQANZPX8Q7jPZ3+th+j7XXSG1z5ycHngxup0W6ol6
         +8I8HBRXfFWC9TiGmJsDg7CULJ0nN+rnt8eDqnBC2sP+Sr41s479kXbftoPmNw+xvnHW
         rHb60HQlIqQzs9WubetNBhRmPlNvBaJIZyuS81hJoRT/PIi7QYMk4675WtKcTPxR8KMP
         qbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hireJk5IsliacX/pLET2ULAtcVeuHiddhIKbm7z+wFU=;
        b=ZFLI1pymEJogN6ko9jFPdvzEYy9o+0vgz2ujHoSHs7G/M1+hq3JHXdixXjz7vXQduy
         okNo83aGcWHovqpFa9i0y6OR/Ejk9z9ina6bPXNdUASMRtog0Nz9fS9xovBbYKm+pzqF
         zjKR5tU/LVnhSErCjG8kx25JwZn4IfuMR0jmyQe+K7uMrSaA63FHTpI9kOmWaBwsJ7KH
         7XtN+I9dY7NurKhGlsGgwDJvkQhdlt1clhskkRKjyIJtQ7sLjsuaWayHKzVDmnoquL+0
         rDQGZ9roodXK3t/J4mm6k/CvbRO4+FzhejWzUYwrmXBL0Io/mTYgmF6aPPZbIn25377u
         t1SA==
X-Gm-Message-State: AJIora/Da/VcrEcKac6cXzlZvpXUZ6yeJruSollOzEuSmAlt5PLB+XM6
        5EhaHXmGp1H4ykZWrXsgKiw=
X-Google-Smtp-Source: AGRyM1uHQzUnabatIn/SGdVv6GubGphcZqva7td5H86oeR/cyrbArqi1w8nd2zNNcEOJ0LP5KNgJUA==
X-Received: by 2002:a17:902:a618:b0:168:9ef0:fb82 with SMTP id u24-20020a170902a61800b001689ef0fb82mr37047704plq.144.1655944373798;
        Wed, 22 Jun 2022 17:32:53 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:29cb])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090a550900b001eaec814132sm4373788pji.3.2022.06.22.17.32.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jun 2022 17:32:53 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        kafai@fb.com, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 5/5] bpf: Relax the requirement to use preallocated hash maps in tracing progs.
Date:   Wed, 22 Jun 2022 17:32:30 -0700
Message-Id: <20220623003230.37497-6-alexei.starovoitov@gmail.com>
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
index a20d7736a5b2..90d70304c6f1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12566,10 +12566,12 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
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
@@ -12579,15 +12581,26 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
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

